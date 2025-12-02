# ns2 + NAM on macOS using Docker

This guide explains how to run **ns2 (Network Simulator 2)** and **NAM (Network Animator)** on macOS inside a Docker container, using XQuartz for GUI support.

---

## 1. Prerequisites

1. **Install Docker Desktop for Mac**
   Download and install: [https://www.docker.com/products/docker-desktop](https://www.docker.com/products/docker-desktop)

2. **Install XQuartz (X11 server)**

   * Download: [https://www.xquartz.org](https://www.xquartz.org)
   * Open the `.dmg` and install it.
   * Log out and log back in (or restart your Mac) after installation.
   * Open **XQuartz → Preferences → Security** → check **“Allow connections from network clients”**.
   * In Terminal, allow Docker containers to connect to XQuartz:

     ```bash
     xhost + 127.0.0.1
     ```

3. **Create a folder for your ns2 scripts**

   ```bash
   mkdir ~/ns2-scripts
   ```

---

## 2. Project Folder Structure

```
ns2-docker-project/
├── Dockerfile
├── docker-compose.yml
└── ns2-scripts/
    ├── example1.tcl
    └── example2.tcl
```

* **Dockerfile** → instructions to build ns2 + NAM image
* **docker-compose.yml** → sets up container, volume mapping, DISPLAY, etc.
* **ns2-scripts/** → folder on your Mac for `.tcl` scripts, mapped inside the container

---

## 3. Dockerfile

Save this as `Dockerfile`:

```dockerfile
FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# Install ns2, NAM, X11 utilities
RUN apt-get update && apt-get install -y \
    ns2 nam xauth x11-apps \
    && rm -rf /var/lib/apt/lists/*

# Set default display environment for Docker Desktop on Mac
ENV DISPLAY=host.docker.internal:0

# Create a folder for scripts inside container
RUN mkdir -p /home/ns2/scripts

# Set default working directory
WORKDIR /home/ns2/scripts

# Default command
CMD ["/bin/bash"]
```

---

## 4. docker-compose.yml

Save this as `docker-compose.yml`:

```yaml
services:
  ns2-nam:
    build:
      context: .
      dockerfile: Dockerfile
    environment:
      - DISPLAY=host.docker.internal:0
    volumes:
      - ./ns2-scripts:/home/ns2/scripts
    stdin_open: true
    tty: true
    platform: linux/amd64   # Only needed for Apple Silicon (M1/M2/M3)
```

---

## 5. Build and Run

From the project root (`ns2-docker-project/`):

```bash
docker-compose up --build
```

* Builds the image (if not already built)
* To starts the container, run: 

```bash
docker-compose run ns2-nam
```


---

## 6. Run ns2 and NAM inside the container

```bash
# Run an ns2 simulation
ns myscript.tcl

# Open NAM to visualize the simulation
nam out.nam
```

---

## 7. Test XQuartz

```bash
xeyes
```

You should see a pair of eyes following your mouse pointer, confirming X11 forwarding works.

---

## 8. Notes

* On Apple Silicon (M1/M2/M3), ensure x86 emulation:

  ```bash
  docker-compose run --platform=linux/amd64 ns2-nam
  ```
* Any files in `~/ns2-scripts` on your Mac are automatically visible inside the container.
* `WORKDIR` ensures you start in the scripts folder automatically.
* You can edit your scripts on Mac; no need to rebuild the image for changes.

---

Now you have a complete setup to run **ns2 + NAM on macOS** using Docker and XQuartz.
