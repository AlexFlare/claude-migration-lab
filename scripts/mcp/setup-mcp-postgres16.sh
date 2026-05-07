claude mcp add postgres \
  -- npx -y @modelcontextprotocol/server-postgres \
  "${POSTGRES_URL:-postgresql://postgres:postgrespass@postgres16:5432/appdb}"

claude mcp list
