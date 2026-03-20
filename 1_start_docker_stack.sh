#!/bin/bash

# ArduPilot ROS2 Docker Stack - Automated Setup
set -e

# Container name (change this if needed)
CONTAINER_NAME="ardupilot_ros"

echo "🚀 ArduPilot ROS2 Docker Stack Setup"
echo "===================================="

# Build and start Docker container
echo "📦 Building Docker container..."
docker compose build
echo "✅ Docker build complete"

echo "🚀 Starting Docker container..."
docker compose up -d
echo "✅ Container started"

# Wait for container to be ready
echo "⏳ Waiting for container to be ready..."
sleep 5

# Enter container and fix it
echo "🔧 Entering container and applying fixes..."
docker exec -it $CONTAINER_NAME bash -l -c "cd ~ && ./fix_docker_container.sh"
echo "✅ Container fixed"

echo ""
echo "🎯 Container is ready!"
echo "📋 Next steps:"
echo "1. Launch simulation: ./2_launch_simulation.sh"
echo "2. Start MAVProxy: ./3_start_mavproxy.sh"
echo "3. Monitor traffic: sudo tcpdump -ni tun0 udp port 14550"
echo ""
echo "✨ Run scripts from host system or inside container!"
