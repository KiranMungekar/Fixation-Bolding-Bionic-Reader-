# Fixation Bolding — Production Dockerfile
# Multi-stage: build deps in stage 1, lean runtime in stage 2

# ---- Build stage ----
FROM python:3.11-slim AS builder

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /build

COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# ---- Runtime stage ----
FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Runtime system libs needed by PyMuPDF (only what's needed, no -dev packages)
RUN apt-get update && apt-get install -y --no-install-recommends \
    libglib2.0-0 \
    libharfbuzz0b \
    libgraphite2-3 \
    libfontconfig1 \
    libfreetype6 \
    libssl3 \
    && rm -rf /var/lib/apt/lists/*

# Copy only the installed Python packages from builder (no build tools brought along)
COPY --from=builder /usr/local/lib/python3.11/site-packages /usr/local/lib/python3.11/site-packages
COPY --from=builder /usr/local/bin /usr/local/bin

WORKDIR /app

# Create non-root user
RUN groupadd -r appuser && useradd -r -g appuser -d /app -s /sbin/nologin appuser && \
    chown -R appuser:appuser /app

# Copy application code
COPY --chown=appuser:appuser ./app /app

USER appuser

EXPOSE 8000

HEALTHCHECK --interval=15s --timeout=5s --start-period=10s --retries=3 \
    CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:8000/')" || exit 1

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
