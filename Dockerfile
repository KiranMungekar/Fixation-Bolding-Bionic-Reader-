# Use the official Python slim image
FROM python:3.11-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Install system dependencies for pymupdf (fitz) and other libs
RUN apt-get update && apt-get install -y \
    gcc \
    libglib2.0-0 \
    libharfbuzz0b \
    libgraphite2-3 \
    libfontconfig1 \
    libfreetype6 \
    libssl-dev \
    build-essential \
    git \
    && rm -rf /var/lib/apt/lists/*

# Create app directory
WORKDIR /app

# Copy requirements
COPY ./requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

# Copy the app code
COPY ./app /app

# Expose port 8000 (FastAPI default)
EXPOSE 8000

# Run the server with uvicorn
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
