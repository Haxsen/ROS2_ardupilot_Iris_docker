#!/bin/bash

# Stop ArduPilot ROS2 Processes (keeps container running)
set -e

# Container name (change this if needed)
CONTAINER_NAME="ardupilot_ros"

echo "🛑 Stopping ArduPilot ROS2 Processes"
echo "=================================="

# Find and stop simulation processes
echo "🔍 Finding simulation processes..."
SIM_PIDS=$(pgrep -f "docker exec.*2_launch_simulation" || true)
if [ -n "$SIM_PIDS" ]; then
    echo "🛑 Stopping simulation processes: $SIM_PIDS"
    echo "$SIM_PIDS" | xargs kill
    echo "✅ Simulation stopped"
else
    echo "ℹ️ No simulation processes found"
fi

# Find and stop MAVProxy processes
echo "🔍 Finding MAVProxy processes..."
MAVPROXY_PIDS=$(pgrep -f "docker exec.*3_start_mavproxy" || true)
if [ -n "$MAVPROXY_PIDS" ]; then
    echo "🛑 Stopping MAVProxy processes: $MAVPROXY_PIDS"
    echo "$MAVPROXY_PIDS" | xargs kill
    echo "✅ MAVProxy stopped"
else
    echo "ℹ️ No MAVProxy processes found"
fi

# Stop processes inside container
echo "🔍 Stopping processes inside container..."
docker exec $CONTAINER_NAME bash -c "pkill -f 'ros2 launch ardupilot_gz_bringup'" || true
docker exec $CONTAINER_NAME bash -c "pkill -f 'mavproxy.py'" || true

echo ""
echo "🎯 Processes stopped, container still running"
echo "📋 Container status: docker ps"
echo "🔧 To restart processes: ./2_launch_simulation.sh && ./3_start_mavproxy.sh"
echo "🛑 To stop container: docker compose down"
