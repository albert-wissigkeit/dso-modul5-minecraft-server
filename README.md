# Minecraft Server Setup

This project provides a custom, containerized Minecraft server setup using Docker and Docker Compose. It allows for easy hosting, configuration, and management of a Minecraft server instance.

---

## Table of Contents

- [Quickstart](#quickstart)
- [Repository Structure](#repository-structure)
- [Usage & Configuration](#usage--configuration)
- [Server Check Script](#server-check-script)
- [Helpful Docker Commands](#helpful-docker-commands)
- [Further References](#further-references)

---

## Quickstart

**Prerequisites:**

- Docker and Docker Compose installed
- Git installed

1. **Clone and enter the repository:**

```bash
git clone git@github.com:albert-wissigkeit/dso-modul5-minecraft-server.git
cd dso-modul5-minecraft-server
git checkout setup-minecraft-server # switch branch if needed
```

2. **Configure environment variables:**

```bash
cp .env.template .env
```

> [!NOTE]
> Adjust the settings inside the `.env` file to your needs, at minimum you must set MC_EULA=true (required to start the server).

3. **Start the server:**

```bash
docker compose up --build -d
```

4. **Verify the server is running:**

```bash
docker ps
```

> [!NOTE]
> Alternatively, use the `server_check.py` script to ping the Server. For more information see [Server Check Script](#server-check-script) below.

5. **(Optional) To Test automatic restart of the Server:**

```bash
sudo reboot
```

> [!NOTE]
> Since the restart policy is configured, the container will automatically start again after a reboot.

6. **Stop the server:**

```bash
docker compose down # (Add `-v` if you want to completely delete the server data/volume).
```

---

## Repository Structure

- `docker-compose.yaml`: Defines the Docker service, port mapping, data persistence (volumes), auto-restart policies, and environment variables.
- `Dockerfile`: Instructions to build the Docker image. It uses `eclipse-temurin:25-alpine` (Java), copies the files, sets the working directory, exposes the port, and defines the entrypoint.
- `entrypoint.sh`: A shell script executed when the container starts. It automatically accepts the Minecraft EULA, applies configuration settings from `.env` to `server.properties`, and starts the `server.jar` with specified RAM allocation.
- `server.jar`: The executable Minecraft server file (downloaded from the official [website](https://www.minecraft.net/de-de/download/server)).
- `server.properties`: Base configuration file for the Minecraft server.
- `.env.template`: Template file containing environment variables for server settings and `server.properties`.
- `.env`: Local environment configuration (created from `.env.template`).
- `.dockerignore`: Excludes unnecessary files and directories (like `.venv` or caches) from the Docker build context.
- `server_check.py`: A Python script utilizing the [mcstatus](https://github.com/py-mine/mcstatus) library to ping and query the server.
- `requirements.txt`: Contains the Python dependencies (`mcstatus`, `asyncio-dgram`, `dnspython`, `python-dotenv`) needed to run `server_check.py`.
- `.gitignore`: Ensures temporary files are not pushed to the repository.

---

## Usage & Configuration

### Modifying Server Settings

You can customize the server behavior easily using the `.env` file:

* **Environment Configuration:**
Copy `.env.template` to `.env` and modify variables such as RAM allocation, port mappings, and `server.properties` settings (e.g., MOTD, max players, difficulty). The `entrypoint.sh` script applies these settings automatically on startup.

### The Minecraft EULA (End User License Agreement)

A standard Minecraft server generates an `eula.txt` file on the first startup and immediately shuts down until `eula=false` is changed to `eula=true` in that file.
This project automates this process: `entrypoint.sh` directly writes `eula=true` into `eula.txt` before launching the `server.jar`. By using this software, you agree to the Minecraft EULA.

---

## Server Check Script

The included `server_check.py` script allows you to easily ping the server and check player count/latency.

**Setup:**

1. Create a virtual environment and install dependencies:

```bash
python -m venv .venv
source .venv/bin/activate  # On Windows use: .venv\Scripts\activate
pip install -r requirements.txt
```

2. Run the script:

```bash
python server_check.py
```

---

## Helpful Docker Commands

Here are additional commands for managing your container and images:

```bash
# Build the image manually without compose
docker build -t mc-server -f ./Dockerfile .

# List all local Docker images
docker image ls

# View live console output of the server (useful for debugging)
docker compose logs -f

# Stop the container and remove the local image
docker compose down --rmi local
```

---

## Further References

- For advanced security recommendations on public servers, refer to the [official Minecraft Server Wiki](https://minecraft.wiki/w/Tutorial:Setting_up_a_Java_Edition_server).
- **Alternative:** If you need a more advanced, community-driven Docker solution with built-in mod support and automated downloads, consider the [itzg/minecraft-server](https://hub.docker.com/r/itzg/minecraft-server) Docker image.
