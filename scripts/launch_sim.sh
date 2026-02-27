#!/bin/bash
# Phase 2: Launch TurtleBot3 simulation in Gazebo (headless)
# Run this inside the Docker container

export LIBGL_ALWAYS_SOFTWARE=1
source /opt/ros/humble/setup.bash
export TURTLEBOT3_MODEL=waffle
ros2 launch turtlebot3_gazebo turtlebot3_world.launch.py headless:=True
