docker run --name postgres16-postgis `
  --network dev-net `
  -e POSTGRES_USER=postgres `
  -e POSTGRES_PASSWORD=postgrespass `
  -e POSTGRES_DB=postgres `
  -p 5432:5432 `
  -v postgres_postgis_data:/var/lib/postgresql/data `
  -d postgis/postgis:16-3.5

Start-Sleep -Seconds 10

docker exec postgres16-postgis psql -U postgres -d postgres -c "CREATE EXTENSION IF NOT EXISTS postgis; CREATE EXTENSION IF NOT EXISTS ltree; CREATE EXTENSION IF NOT EXISTS citext; CREATE EXTENSION IF NOT EXISTS pgcrypto;"

docker exec postgres16-postgis psql -U postgres -d postgres -c "SELECT extname, extversion FROM pg_extension ORDER BY extname;"