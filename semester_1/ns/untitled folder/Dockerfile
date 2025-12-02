FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# Install ns2, nam and X11 utils
RUN apt-get update && apt-get install -y \
    ns2 nam xauth x11-apps \
    && rm -rf /var/lib/apt/lists/*

# Set default display environment (Docker Desktop for Mac uses host.docker.internal)
ENV DISPLAY=host.docker.internal:0

# Create a user folder for scripts
RUN mkdir -p /home/ns2/scripts

# Set working directory
WORKDIR /home/ns2/scripts

# Default command when container starts
CMD ["/bin/bash"]
