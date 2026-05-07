# Docker Build Scripts

This repository contains PowerShell scripts for building and running local Docker development images.

## Images

| Image | Description |
|---|---|
| `ubuntu-claude-dev` | Ubuntu 22.04 with Python 3, Node.js 20, Git, network tools, Midnight Commander, and Claude Code |
| `postgres16` | PostgreSQL 16 development database |
| `mssql2022` | SQL Server 2022 development database |

## Network

All containers use the Docker network:
```text
dev-net
