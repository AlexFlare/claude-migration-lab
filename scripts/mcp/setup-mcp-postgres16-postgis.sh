claude mcp add postgres \
  -- npx -y @modelcontextprotocol/server-postgres \
  "${POSTGRES_URL:-postgresql://postgres:postgrespass@postgres16-postgis:5432/postgres}"

claude mcp list
