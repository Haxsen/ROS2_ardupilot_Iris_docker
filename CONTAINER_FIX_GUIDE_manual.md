# Docker Container Fix Guide

## 🚀 Quick Container Fix

The fix script is now built into the container! You can run it directly:

### **Step 1: Enter Container**
```bash
docker exec -it <container_name> bash
```

### **Step 2: Run Built-in Fix Script**
```bash
# The script is already in the container at /home/ros/fix_docker_container.sh
cd ~
./fix_docker_container.sh
```

### **Step 3: Launch Simulation**
```bash
source ~/.bashrc
ros2 launch ardupilot_gz_bringup iris_runway.launch.py
```

---

## 📋 What the Fix Script Does

1. **Navigate to workspace root** (`cd ~/ros2_ws`)
2. **Remove existing builds** (`rm -rf build install`)
3. **Build required packages**:
   - `ardupilot_gazebo` (Gazebo plugins)
   - `ardupilot_gz_bringup` (launch files)
4. **Source workspace** and **add to ~/.bashrc** for persistence

---

## 🔧 Manual Fix Commands

If you prefer manual commands:

```bash
cd ~/ros2_ws
rm -rf build install
colcon build --packages-select ardupilot_gazebo
colcon build --packages-up-to ardupilot_gz_bringup
source install/setup.bash
```

---

## 🎯 After Fix

1. **Terminal 1**: `ros2 launch ardupilot_gz_bringup iris_runway.launch.py`
2. **Terminal 2**: `mavproxy.py --console --map --aircraft test --master=:14550 --out=172.27.233.201:14550`
3. **Terminal 3** (host): `sudo tcpdump -ni tun0 udp port 14550`

✅ **Container ready for ArduPilot SITL + Gazebo simulation!**

---

## 🏗️ Container Integration

The fix script is now:
- ✅ **Copied to container**: `/home/ros/fix_docker_container.sh`
- ✅ **Made executable**: `chmod +x`
- ✅ **Available immediately** when container starts
