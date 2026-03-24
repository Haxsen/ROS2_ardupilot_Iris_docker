# ArduPilot ROS2 Docker - Automated Quick Setup Guide

## 🚀 One-Command Setup

Run this single script to get everything working:

```bash
sudo chmod +x 1_start_docker_stack.sh 2_launch_simulation.sh 3_start_mavproxy.sh 0_stop_processes.sh
./1_start_docker_stack.sh
```

## 📋 What This Script Does

1. **📦 Builds Docker container** (`docker compose build`)
2. **🚀 Starts container** (`docker compose up -d`)
3. **🔧 Fixes container** (runs built-in fix script)
4. **🎯 Shows next steps** (doesn't auto-launch)

## 🎯 Individual Scripts

### **Launch Simulation**
Launches gazebo with ros2 integration
```bash
./2_launch_simulation.sh
```

### **Start MAVProxy**
Starts MAVProxy to connect to ArduPilot and allow external connections on port 14550 (default).
```bash
CLIENT_IP=YOUR_VPN_PROVIDED_IP ./3_start_mavproxy.sh
```
OR
```bash
export CLIENT_IP=YOUR_VPN_PROVIDED_IP
./3_start_mavproxy.sh
```

## 🛑 Stopping Processes

```bash
# Clean stop all processes (container keeps running)
./0_stop_processes.sh
```

## 📊 Monitoring

```bash
# UDP traffic (host)
sudo tcpdump -ni tun0 udp port 14550

# ROS2 topics
docker exec -it ardupilot_ros bash -c "source ~/.bashrc && ros2 topic list"
```

## ✅ Success Indicators

- ✅ **Gazebo GUI** opens with Iris drone
- ✅ **MAVProxy** shows "Detected vehicle 1:1"
- ✅ **UDP traffic** visible in tcpdump
- ✅ **Client ready** to connect via QGroundControl

**QGroundControl Connection:**
- **Host**: `172.27.233.202` (VM's VPN IP)
- **Port**: `14550`

## 🔄 Restart Commands

```bash
# After stopping, restart processes:
./2_launch_simulation.sh && ./3_start_mavproxy.sh
```

## 📝 Possible errors and fixes

- Gazebo GUI launches but hangs / crashes on `2_launch_simulation.sh`.
    - Check and fix the display env var in [docker-compose.yml](./docker-compose.yml) (`DISPLAY=<value>`).