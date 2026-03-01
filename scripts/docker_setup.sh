#!/bin/bash
# Full Docker container setup for Spot autonomous navigation stack
# Run this inside a fresh osrf/ros:humble-desktop container
#
# To create the container:
#   docker run -it --name spot_nav -p 9090:9090 osrf/ros:humble-desktop bash
#
# Then run this script inside the container:
#   bash docker_setup.sh

set -e

echo "=== Installing ROS 2 packages ==="
sudo apt update
sudo apt install -y ros-humble-turtlebot3* ros-humble-gazebo-* ros-humble-navigation2 ros-humble-nav2-bringup ros-humble-slam-toolbox

echo "=== Setting environment variables ==="
echo 'export TURTLEBOT3_MODEL=waffle' >> ~/.bashrc
echo 'export GAZEBO_MODEL_PATH=$GAZEBO_MODEL_PATH:/opt/ros/humble/share/turtlebot3_gazebo/models' >> ~/.bashrc
echo 'source /opt/ros/humble/setup.bash' >> ~/.bashrc
source ~/.bashrc

echo "=== Building explore_lite from source ==="
mkdir -p /root/explore_ws/src
cd /root/explore_ws/src
git clone https://github.com/robo-friends/m-explore-ros2.git
cd /root/explore_ws

# Fix QoS mismatch - explore_lite subscribes with VOLATILE but Nav2 costmap publishes with TRANSIENT_LOCAL
sed -i 's/      costmap_topic, 1000,/      costmap_topic, rclcpp::QoS(rclcpp::KeepLast(1)).transient_local().reliable(),/' /root/explore_ws/src/m-explore-ros2/explore/src/costmap_client.cpp

rosdep install --from-paths src --ignore-src -r -y
colcon build --packages-select explore_lite explore_lite_msgs
echo 'source /root/explore_ws/install/setup.bash' >> ~/.bashrc
source ~/.bashrc

echo "=== Creating nav2_params.yaml ==="
cp /opt/ros/humble/share/nav2_bringup/params/nav2_params.yaml /root/nav2_params.yaml
sed -i 's/use_astar: false/use_astar: true/g' /root/nav2_params.yaml

echo "=== Setup complete ==="
echo ""
echo "To run the full exploration stack, open 4 terminals and run:"
echo ""
echo "Terminal 1 - Gazebo:"
echo "  source ~/.bashrc && export LIBGL_ALWAYS_SOFTWARE=1 && ros2 launch turtlebot3_gazebo turtlebot3_world.launch.py headless:=True"
echo ""
echo "Terminal 2 - SLAM Toolbox:"
echo "  source ~/.bashrc && ros2 launch slam_toolbox online_async_launch.py use_sim_time:=True"
echo ""
echo "Terminal 3 - Nav2:"
echo "  source ~/.bashrc && ros2 launch nav2_bringup navigation_launch.py use_sim_time:=True params_file:=/root/nav2_params.yaml"
echo ""
echo "Terminal 4 - Explore Lite:"
echo "  source ~/.bashrc && ros2 run explore_lite explore --ros-args -p costmap_topic:=map -p use_sim_time:=True"
