#!/bin/bash

# Launch ArduPilot ROS2 Simulation (called from host)
set -e

# Container name (change this if needed)
CONTAINER_NAME="ardupilot_ros"

echo "🚁 Launching ArduPilot ROS2 Simulation"
echo "=================================="

# Launch simulation inside container
echo "🚀 Starting Gazebo + ArduPilot SITL..."
docker exec $CONTAINER_NAME bash -c "source ~/.bashrc && ros2 launch ardupilot_gz_bringup iris_runway.launch.py" &

SIM_PID=$!
echo "✅ Simulation launched in background! (PID: $SIM_PID)"
echo "To stop simulation cleanly, run: kill $SIM_PID"
echo "📊 Monitor with: docker exec -it $CONTAINER_NAME bash -c 'source ~/.bashrc && ros2 topic list'"
