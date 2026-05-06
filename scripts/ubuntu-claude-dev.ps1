# create-ubuntu-claude-dev.ps1

$ImageName = "ubuntu-claude-dev:22.04"
$ContainerName = "ubuntu-claude-dev"
$BuildDir = ".\ubuntu-claude-dev"
$DockerNetwork = "dev-net"

# -----------------------------
# Create build directory
# -----------------------------

New-Item -ItemType Directory -Path $BuildDir -Force | Out-Null

# -----------------------------
# Create Dockerfile
# -----------------------------

@'
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC

RUN apt-get update && apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    git \
    python3 \
    python3-pip \
    python3-venv \
    build-essential \
    unzip \
    nano \
    sudo \
    iputils-ping \
    telnet \
    mc \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js 20+
RUN mkdir -p /etc/apt/keyrings \
    && curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key \
      | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg \
    && echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" \
      > /etc/apt/sources.list.d/nodesource.list \
    && apt-get update \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

# Install Claude Code
RUN npm install -g @anthropic-ai/claude-code

# Create non-root developer user
RUN useradd -ms /bin/bash developer \
    && usermod -aG sudo developer \
    && echo "developer ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/developer

USER developer
WORKDIR /workspace

CMD ["/bin/bash"]
'@ | Set-Content -Path "$BuildDir\Dockerfile" -Encoding UTF8

# -----------------------------
# Build Docker image
# -----------------------------

docker build -t $ImageName $BuildDir

if ($LASTEXITCODE -ne 0) {
    throw "Docker build failed."
}

# -----------------------------
# Ensure dev-net exists
# -----------------------------

docker network inspect $DockerNetwork *> $null

if ($LASTEXITCODE -ne 0) {
    docker network create $DockerNetwork

    if ($LASTEXITCODE -ne 0) {
        throw "Failed to create Docker network: $DockerNetwork"
    }
}

# -----------------------------
# Remove existing container
# -----------------------------

docker rm -f $ContainerName 2>$null

# -----------------------------
# Run container in dev-net
# -----------------------------

docker run -it `
  --name $ContainerName `
  --network $DockerNetwork `
  -v "${PWD}:/workspace" `
  -w /workspace `
  $ImageName