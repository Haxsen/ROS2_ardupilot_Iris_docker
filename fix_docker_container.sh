#!/bin/bash

# ArduPilot ROS2 Docker Container Fix Script
# This script fixes the Docker container to make ArduPilot SITL + Gazebo work properly

set -e

echo "🔧 ArduPilot ROS2 Docker Container Fix Script"
echo "============================================="

# Navigate to workspace root
echo "📍 Navigating to workspace root..."
cd ~/ros2_ws

# Remove build/install dirs
echo "🗑️ Removing build/install dirs..."
rm -rf build install || true

# Build required packages
echo "🔨 Building ardupilot_gazebo package..."
colcon build --packages-select ardupilot_gazebo
echo "  ✅ Built ardupilot_gazebo"

echo "🔨 Building ardupilot_gz_bringup and dependencies..."
colcon build --packages-up-to ardupilot_gz_bringup
echo "  ✅ Built ardupilot_gz_bringup and dependencies"

# Source the workspace
echo "🔗 Sourcing workspace environment..."
source install/setup.bash
echo "  ✅ Workspace sourced"

# Add to bashrc for persistence
if ! grep -q "source ~/ros2_ws/install/setup.bash" ~/.bashrc; then
    echo "source ~/ros2_ws/install/setup.bash" >> ~/.bashrc
    echo "  ✅ Added workspace sourcing to ~/.bashrc"
fi

echo ""
echo "🎉 Docker container fix completed successfully!"
echo ""
echo "📋 Next Steps:"
echo "  1. Launch the simulation:"
echo "     ros2 launch ardupilot_gz_bringup iris_runway.launch.py"
echo ""
echo "  2. In another terminal, connect MAVProxy:"
echo "     mavproxy.py --console --map --aircraft test --master=:14550 --out=172.27.233.201:14550"
echo ""
echo "  3. Verify UDP traffic on host:"
echo "     sudo tcpdump -ni tun0 udp port 14550"
echo ""
echo "✨ The container is now ready for ArduPilot SITL + Gazebo simulation!"
