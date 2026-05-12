# Docker Build Scripts

The repository contains PowerShell and Bash scripts for building and running local Claude Code development environment on Windows PC.

## Images

| Image | Description |
|---|---|
| `postgres16-postgis` | PostgreSQL 16 Postgis database engine |
| `mssql2022` | SQL Server 2022 database engine with Adventureworks2022 |
| `ubuntu-claude-dev` | Ubuntu 22.04 with Python 3, Node.js 20, Git, network tools, postgresql-client, Midnight Commander and Claude Code |

## Network

All containers use the Docker network:
```text
dev-net
```

# Installation
1. Build and run Postgres16 Postgis docker container [https://github.com/AlexFlare/claude-migration-lab/blob/main/scripts/docker-powershell/postgres16-postgis.ps1]
2. Build and run MSSQL2022 with Adventureworks2022 docker container [https://github.com/AlexFlare/claude-migration-lab/blob/main/scripts/docker-powershell/mssql2022.ps1]
3. Build and run Ubuntu Linux docker container [https://github.com/AlexFlare/claude-migration-lab/blob/main/scripts/docker-powershell/ubuntu-claude-dev.ps1]
4. Add Claude MCP servers for Postgres and MSSQL running scripts on the Ubuntu Linux terminal [https://github.com/AlexFlare/claude-migration-lab/tree/main/scripts/mcp]
