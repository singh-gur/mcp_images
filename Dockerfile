FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1 \
    MCP_TRANSPORT=streamable-http \
    MCP_HOST=0.0.0.0 \
    MCP_PORT=8000 \
    DDG_SAFE_SEARCH=MODERATE \
    DDG_REGION=

RUN pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir duckduckgo-mcp-server

COPY docker-entrypoint.py /app/docker-entrypoint.py

EXPOSE 8000

ENTRYPOINT ["python", "/app/docker-entrypoint.py"]
