#!/usr/bin/env python3

import os

from duckduckgo_mcp_server.server import mcp


def main() -> None:
    mcp.settings.host = os.getenv("MCP_HOST", "0.0.0.0")
    mcp.settings.port = int(os.getenv("MCP_PORT", "8000"))
    mcp.settings.transport_security = None
    mcp.run(transport=os.getenv("MCP_TRANSPORT", "streamable-http"))


if __name__ == "__main__":
    main()
