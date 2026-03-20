# ArduPilot ROS2 Docker - Quick Setup Guide

## 🚁 Overview
Complete Docker environment for ArduPilot SITL simulation with Gazebo integration and MAVLink telemetry over VPN.

---

## 🎯 Minimum Commands for New Container

### **Step 1: Navigate to Workspace**
```bash
cd ..
```

### **Step 2: Backup Previous Build**
```bash
mv build build1
mv install install1
```

### **Step 3: Build Required Packages**
```bash
colcon build --packages-select ardupilot_gazebo
colcon build --packages-up-to ardupilot_gz_bringup
```

### **Step 4: Source Environment**
```bash
source install/setup.bash
```

### **Step 5: Launch Simulation**
```bash
ros2 launch ardupilot_gz_bringup iris_runway.launch.py
```

---

## 📋 Complete Setup Sequence

### **Terminal 1: Start Simulation**
```bash
cd ~/ros2_ws
source install/setup.bash
ros2 launch ardupilot_gz_bringup iris_runway.launch.py
```

### **Terminal 2: Connect MAVProxy with VPN Output**
```bash
mavproxy.py --console --map --aircraft test --master=:14550 --out=172.27.233.201:14550
```

### **Terminal 3: Verify UDP Traffic (Host System)**
```bash
sudo tcpdump -ni tun0 udp port 14550
# Expected: 172.27.233.202 → 172.27.233.201 UDP 14550
```

---

## ✅ Success Indicators

- ✅ **Gazebo GUI** opens with Iris drone model
- ✅ **ArduPilot SITL** shows "AP: ArduCopter V4.8.0-dev"
- ✅ **MAVProxy** shows "Detected vehicle 1:1"
- ✅ **UDP traffic** appears in tcpdump
- ✅ **Client ready** to connect via QGroundControl/Mission Planner

---

## 🔧 Common Issues & Quick Fixes

### **Issue: "package 'ardupilot_gz_bringup' not found"**
```bash
# Fix: Build the missing package
colcon build --packages-up-to ardupilot_gz_bringup
```

### **Issue: Gazebo plugin loading errors**
```bash
# Fix: Build ardupilot_gazebo package
colcon build --packages-select ardupilot_gazebo
```

### **Issue: No UDP traffic in tcpdump**
```bash
# Fix: Use correct client IP in MAVProxy
mavproxy.py --out=172.27.233.201:14550  # Client IP, not server IP
```

---

## 🎯 Key Points

1. **Always build dependencies** with `--packages-up-to`
2. **Source workspace** before launching
3. **Use client IP** for MAVProxy UDP output
4. **Verify with tcpdump** to confirm VPN traffic

---

## 📞 Client Connection

**Connect QGroundControl/Mission Planner to:** `172.27.233.202:14550`

---

## 🚁 Final Result

**Expected MAVLink Traffic:**
```
10:53:24.111513 IP 172.27.233.202.55413 > 172.27.233.201.14550: UDP, length 34
10:53:24.112737 IP 172.27.233.202.55413 > 172.27.233.201.14550: UDP, length 34
```

**Expected MAVProxy Status:**
```
Detected vehicle 1:1 on link 0
online system 1
AP: ArduCopter V4.8.0-dev
```

🎉 **Complete system operational with live MAVLink telemetry over VPN!**
