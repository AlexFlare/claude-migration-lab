docker run --name postgres16-postgis `
  --network dev-net `
  -e POSTGRES_USER=postgres `
  -e POSTGRES_PASSWORD=postgrespass `
  -e POSTGRES_DB=postgres `
  -p 5432:5432 `
  -v postgres16_postgis_data:/var/lib/postgresql/data `
  -d postgis/postgis:16-3.5

Start-Sleep -Seconds 8

docker exec postgres16-postgis psql -U postgres -d postgres `
  -c "CREATE EXTENSION IF NOT EXISTS postgis; SELECT PostGIS_Version();"