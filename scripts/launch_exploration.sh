#!/bin/bash
# Phase 4: Full autonomous exploration stack
# Run each command in a separate terminal inside the Docker container

# Terminal 1 - Gazebo simulation
# source ~/.bashrc && export LIBGL_ALWAYS_SOFTWARE=1 && ros2 launch turtlebot3_gazebo turtlebot3_world.launch.py headless:=True

# Terminal 2 - SLAM Toolbox (builds map from LiDAR, provides map->odom transform)
# source ~/.bashrc && ros2 launch slam_toolbox online_async_launch.py use_sim_time:=True

# Terminal 3 - Nav2 (path planning, obstacle avoidance, recovery behaviors)
# source ~/.bashrc && ros2 launch nav2_bringup navigation_launch.py use_sim_time:=True params_file:=/root/nav2_params.yaml

# Terminal 4 - Explore Lite (frontier detection, autonomous goal selection)
# source ~/.bashrc && ros2 run explore_lite explore --ros-args -p costmap_topic:=map -p use_sim_time:=True