#!/bin/bash
# Spot Autonomous Exploration - Launch Sequence
# Run each section in a separate Docker terminal
# Connect to Spot WiFi before starting

# ============ TERMINAL 1: Spot Driver ============
# docker start -i spot_nav
# source ~/.bashrc
# export SPOT_IP=192.168.80.3
# ros2 launch spot_driver spot_driver.launch.py spot_name:=spot

# ============ TERMINAL 2: Depth to LaserScan ============
# docker exec -it spot_nav bash
# source ~/.bashrc
# ros2 run depthimage_to_laserscan depthimage_to_laserscan_node --ros-args -r depth:=/spot/depth/frontleft/image -r depth_camera_info:=/spot/depth/frontleft/camera_info -r scan:=/scan -p range_min:=0.3 -p range_max:=10.0 -p scan_height:=10 -p output_frame:=spot/frontleft

# ============ TERMINAL 3: SLAM Toolbox ============
# docker exec -it spot_nav bash
# source ~/.bashrc
# ros2 launch slam_toolbox online_async_launch.py slam_params_file:=/root/slam_params.yaml

# ============ TERMINAL 4: Nav2 ============
# docker exec -it spot_nav bash
# source ~/.bashrc
# ros2 launch nav2_bringup navigation_launch.py params_file:=/root/nav2_params.yaml

# ============ TERMINAL 5: Explore Lite ============
# IMPORTANT: Walk Spot around manually for 1-2 minutes first to build the map
# Then start explore_lite:
# docker exec -it spot_nav bash
# source ~/.bashrc
# ros2 run explore_lite explore --ros-args -p costmap_topic:=map -p robot_base_frame:=spot/body -p transform_tolerance:=1.0
