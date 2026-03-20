#!/bin/bash

# Launch ArduPilot ROS2 Simulation (called from host)
set -e

echo "🚁 Launching ArduPilot ROS2 Simulation"
echo "=================================="

# Launch simulation inside container
echo "🚀 Starting Gazebo + ArduPilot SITL..."
docker exec -it ardupilot_ros bash -c "source ~/.bashrc && ros2 launch ardupilot_gz_bringup iris_runway.launch.py" &

SIM_PID=$!
echo "✅ Simulation launched in background! (PID: $SIM_PID)"
echo "To stop the simulation cleanly, run: kill $SIM_PID"
echo "📊 Monitor with: docker exec -it ardupilot_ros bash -c 'source ~/.bashrc && ros2 topic list'"
