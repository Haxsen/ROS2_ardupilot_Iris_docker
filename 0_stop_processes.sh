#!/bin/bash

# Stop ArduPilot ROS2 Processes (keeps container running)
set -e

# Container name (change this if needed)
CONTAINER_NAME="ardupilot_ros"

echo "🛑 Stopping ArduPilot ROS2 Processes"
echo "=================================="

# Force kill all processes
echo "🔍 Force killing processes..."
GAZEBO_COUNT=$(pgrep -f "gazebo" | wc -l || echo "0")
GAZEBO_KILLED=$(pkill -9 -f "gazebo" && echo "gazebo processes killed ($GAZEBO_COUNT killed)" || echo "no gazebo processes found")
GZSIM_COUNT=$(pgrep -f "gz sim" | wc -l || echo "0")
GZSIM_KILLED=$(pkill -9 -f "gz sim" && echo "gz sim processes killed ($GZSIM_COUNT killed)" || echo "no gz sim processes found")
MAVPROXY_COUNT=$(pgrep -f "mavproxy" | wc -l || echo "0")
MAVPROXY_KILLED=$(pkill -9 -f "mavproxy" && echo "mavproxy processes killed ($MAVPROXY_COUNT killed)" || echo "no mavproxy processes found")
echo "  $GAZEBO_KILLED"
echo "  $GZSIM_KILLED"
echo "  $MAVPROXY_KILLED"

echo ""
echo "✅ All processes stopped, container still running"
echo "📋 Container status: docker ps"
echo "🔧 To restart: ./2_launch_simulation.sh && ./3_start_mavproxy.sh"
echo "🛑 To stop container: docker compose down"
