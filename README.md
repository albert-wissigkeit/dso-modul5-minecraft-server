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

2. **Start the server:**

```bash
docker compose up --build -d
```

3. **Verify the server is running:**

```bash
docker ps
```

> Note: _Alternatively, use the `server_check.py` script (adjust the IP address in the script first)._

4. **(Optional) To Test automatic restart of the Server:**

```bash
sudo reboot
```

> Note: _Since `restart: always` is configured, the container will automatically start again after a reboot._

5. **Stop the server:**

```bash
docker compose down
```

> Note: _(Add `-v` if you want to completely delete the server data/volume)._

---

## Repository Structure

- `docker-compose.yaml`: Defines the Docker service, port mapping, data persistence (volumes), and auto-restart policies.
- `Dockerfile`: Instructions to build the Docker image. It uses `eclipse-temurin:25` (Java), copies the files, sets the working directory, exposes the port, and defines the entrypoint.
- `entrypoint.sh`: A shell script executed when the container starts. It automatically accepts the Minecraft EULA and starts the `server.jar` with specified RAM allocation.
- `server.jar`: The executable Minecraft server file (downloaded from the official [website](https://www.minecraft.net/de-de/download/server) ).
- `server_check.py`: A Python script utilizing the [mcstatus](https://github.com/py-mine/mcstatus) library to ping and query the server.
- `requirements.txt`: Contains the Python dependencies (`mcstatus`, `asyncio-dgram`, `dnspython`) needed to run `server_check.py`.
- `.gitignore`: Ensures temporary files (like `.venv` or caches) are not pushed to the repository.

---

## Usage & Configuration

### Modifying Server Settings

You can customize the server behavior by modifying the provided files:

- **Change Ports:**
  Open `docker-compose.yaml` and change the left side of the `ports` mapping.
  For example, to use the default Minecraft port on your host machine:
  `- 25565:25565` (Format is `HOST:CONTAINER`).
- **Adjust RAM Allocation:**
  Open `entrypoint.sh` and modify the Java arguments.
  `-Xmx2G -Xms2G` assigns a maximum and minimum of 2 Gigabytes of RAM. Change `2G` to `4G` if you need 4 Gigabytes, etc.

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

2. Modify `server_check.py` to target your IP:

```python
server = JavaServer.lookup("<your_ip>:8888")
```

3. Run the script:

```bash
python server_check.py
```

---

## Helpful Docker Commands

Here are additional commands for managing your container and images:

```bash
# Build the image manually without compose
docker build -t  -f ./Dockerfile .

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
