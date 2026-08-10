# Docker container for deployment

The Server is packaged as a Docker container so that `pymupdf`'s system-level dependencies are bundled and the app runs identically on local machines and remote hosts. Rejected alternatives: running bare on a local dev box only (not deployable); depending on a PaaS like Railway/Fly.io (platform-specific constraints around request timeouts and memory that conflict with 50 MB synchronous PDF processing). The container can be deployed to AWS, a VPS, or run locally without modification.
