claude mcp add mssql \
  --env DB_HOST=mssql2022 \
  --env DB_PORT=1433 \
  --env DB_USERNAME=sa \
  --env 'DB_PASSWORD=YourStrong!Passw0rd' \
  --env DB_DATABASE=adventureworks2022 \
  --env DB_ENCRYPT=false \
  --env DB_TRUST_SERVER_CERTIFICATE=true \
  --env TRUSTED_CONNECTION=false \
  -- npx -y mcp-node-mssql

claude mcp list
