# ArduPilot ROS2 Docker - Automated Quick Setup Guide

## 🚀 One-Command Setup

Run this single script to get everything working:

```bash
sudo chmod +x start_docker_stack.sh launch_simulation.sh start_mavproxy.sh stop_processes.sh
./start_docker_stack.sh
```

## 📋 What This Script Does

1. **📦 Builds Docker container** (`docker compose build`)
2. **🚀 Starts container** (`docker compose up -d`)
3. **🔧 Fixes container** (runs built-in fix script)
4. **🎯 Shows next steps** (doesn't auto-launch)

## 🎯 Individual Scripts

### **Launch Simulation**
```bash
# From host system (recommended)
./launch_simulation.sh
# Shows PID for clean shutdown: kill <PID>
```

### **Start MAVProxy**
```bash
# From host system (recommended)  
./start_mavproxy.sh
# Shows PID for clean shutdown: kill <PID>
```

## 🛑 Stopping Processes

```bash
# Clean stop all processes (container keeps running)
./stop_processes.sh

# Or manual stop:
kill <SIMULATION_PID>
kill <MAVPROXY_PID>

# Stop container completely
docker compose down

# Force stop all processes
pkill -f "docker exec.*launch_simulation"
pkill -f "docker exec.*start_mavproxy"
```

## ⚙️ Configuration

Edit `start_mavproxy.sh` to change:
- **Client IP**: Default `172.27.233.201`
- **Port**: Default `:14550`

## 📊 Monitoring

```bash
# ROS2 topics
docker exec -it ardupilot_ros bash -c "source ~/.bashrc && ros2 topic list"

# UDP traffic (host)
sudo tcpdump -ni tun0 udp port 14550
```

## ✅ Success Indicators

- ✅ **Gazebo GUI** opens with Iris drone
- ✅ **MAVProxy** shows "Detected vehicle 1:1"
- ✅ **UDP traffic** visible in tcpdump
- ✅ **Client ready** to connect via QGroundControl

**Client connects to:** `172.27.233.202:14550`
