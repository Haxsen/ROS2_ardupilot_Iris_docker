#!/bin/bash

# Launch ArduPilot ROS2 Simulation (called from host)
set -e

# Container name (change this if needed)
CONTAINER_NAME="ardupilot_ros"

echo "🚁 Launching ArduPilot ROS2 Simulation"
echo "=================================="

# Launch simulation inside container (foreground)
echo "🚀 Starting Gazebo + ArduPilot SITL..."
echo "📋 Press Ctrl+C to stop simulation"
docker exec -it $CONTAINER_NAME bash -l -c "source ~/.bashrc && ros2 launch ardupilot_gz_bringup iris_runway.launch.py"

echo "✅ Simulation stopped"
