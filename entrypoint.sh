#!/bin/bash

set -e

source /opt/ros/humble/setup.bash
source ~/ros2_ws/install/setup.bash

echo "Container ready. ArduPilot ROS2 environment loaded."
echo "Available commands:"
echo "  ./fix_docker_container.sh  - Fix container build issues"
echo "  ./2_launch_simulation.sh  - Launch Gazebo + ArduPilot SITL"
echo "  ./3_start_mavproxy.sh    - Start MAVProxy with UDP output"
echo "  ./0_stop_processes.sh     - Stop all processes"

# Keep container running
exec bash
