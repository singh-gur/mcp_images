set shell := ["bash", "-cu"]
set positional-arguments

image := "duckduckgo-mcp-server:latest"
service := "ddg-search"
port := "8000"

# Show all available commands
default:
    @just --list --unsorted

# Rich CLI help with common workflows
help:
    @printf "DuckDuckGo MCP Server local workflow\n\n"
    @printf "Quick start:\n"
    @printf "  just build\n"
    @printf "  just up\n"
    @printf "  just logs\n\n"
    @printf "Common commands:\n"
    @printf "  just build             Build Docker image via compose\n"
    @printf "  just up                Start service in background\n"
    @printf "  just down              Stop and remove service\n"
    @printf "  just restart           Restart service\n"
    @printf "  just ps                Show compose service status\n"
    @printf "  just logs              Follow logs for default service\n"
    @printf "  just logs ddg-search   Follow logs for a specific service\n"
    @printf "  just test-http         Check MCP HTTP endpoint locally\n"
    @printf "  just run-image         Run the image directly with docker run\n\n"
    @printf "Tips:\n"
    @printf "  - Override image tag: just run-image image_tag=duckduckgo-mcp-server:v1\n"
    @printf "  - Override port:      just run-image host_port=8080\n"
    @printf "\n"

# Build docker image(s)
build:
    docker compose build

# Start service stack
up:
    docker compose up -d

# Stop and remove service stack
down:
    docker compose down

# Restart running service stack
restart:
    docker compose restart

# Follow logs for service (defaults to ddg-search)
logs svc=service:
    docker compose logs -f {{svc}}

# Show container status
ps:
    docker compose ps

# Quick local protocol smoke test
test-http:
    curl -i -X POST "http://localhost:{{port}}/mcp" \
      -H "content-type: application/json" \
      -d '{"jsonrpc":"2.0","id":1,"method":"initialize","params":{"protocolVersion":"2024-11-05","capabilities":{},"clientInfo":{"name":"just-smoke-test","version":"0.1.0"}}}'

# Run image directly (without compose)
run-image image_tag=image host_port=port:
    docker run --rm -p {{host_port}}:8000 \
      -e MCP_TRANSPORT=streamable-http \
      -e MCP_HOST=0.0.0.0 \
      -e MCP_PORT=8000 \
      -e DDG_SAFE_SEARCH=MODERATE \
      -e DDG_REGION= \
      {{image_tag}}
