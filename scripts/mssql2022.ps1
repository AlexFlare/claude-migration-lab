docker pull mcr.microsoft.com/mssql/server:2022-latest

docker run -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=YourStrong!Passw0rd" -e "MSSQL_PID=Developer" -p 1433:1433 --name mssql2022 --network dev-net -d mcr.microsoft.com/mssql/server:2022-latest

mkdir backup -Force

Invoke-WebRequest `
  -Uri "https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorks2022.bak" `
  -OutFile ".\backup\AdventureWorks2022.bak"

docker cp .\backup\AdventureWorks2022.bak mssql2022:/var/opt/mssql/data/AdventureWorks2022.bak

docker exec -it mssql2022 /opt/mssql-tools18/bin/sqlcmd `
  -S localhost `
  -U sa `
  -P "YourStrong!Passw0rd" `
  -C `
  -Q "RESTORE DATABASE AdventureWorks2022 FROM DISK = '/var/opt/mssql/data/AdventureWorks2022.bak' WITH MOVE 'AdventureWorks2022' TO '/var/opt/mssql/data/AdventureWorks2022.mdf', MOVE 'AdventureWorks2022_log' TO '/var/opt/mssql/data/AdventureWorks2022_log.ldf', REPLACE"

docker exec -it mssql2022 /opt/mssql-tools18/bin/sqlcmd `
  -S localhost `
  -U sa `
  -P "YourStrong!Passw0rd" `
  -C `
  -Q "SELECT name FROM sys.databases;"
