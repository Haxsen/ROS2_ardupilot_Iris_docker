#!/bin/bash

# Start MAVProxy with UDP Output (called from host)
set -e

# Container name (change this if needed)
CONTAINER_NAME="ardupilot_ros"

# Configuration - Change these as needed
CLIENT_IP="172.27.233.201"
MASTER_PORT=":14550"

echo "📡 Starting MAVProxy"
echo "==================="

echo "🔗 Connecting to local ArduPilot on port $MASTER_PORT"
echo "📤 Outputting UDP to client at $CLIENT_IP$MASTER_PORT"

# Start MAVProxy inside container
docker exec $CONTAINER_NAME bash -c "mavproxy.py --console --map --aircraft test --master=$MASTER_PORT --out=$CLIENT_IP$MASTER_PORT" &

MAVPROXY_PID=$!
echo "✅ MAVProxy connected in background! (PID: $MAVPROXY_PID)"
echo "To stop MAVProxy cleanly, run: kill $MAVPROXY_PID"
echo "📊 Monitor with: docker exec -it $CONTAINER_NAME bash -c 'source ~/.bashrc && ros2 topic echo /mavlink/*'"
