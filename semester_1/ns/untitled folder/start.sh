#!/bin/bash

# Start XQuartz if not already running
open -a XQuartz

# Wait for XQuartz to be ready (optional, helps avoid race conditions)
sleep 2

# Allow local Docker containers to access X11
xhost +localhost

# Build and start containers in detached mode
docker compose up --remove-orphans --build -d 

# Run the ns2-nam service interactively
docker compose run ns2-nam
