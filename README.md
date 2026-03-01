# Spot Autonomous Navigation Stack

Fully autonomous navigation and exploration system for Boston Dynamics Spot using its 5 built-in monochrome stereo camera pairs.

## What It Does

Drop Spot into an unknown room, press "Explore," and walk away. Spot autonomously maps the entire space using frontier-based exploration, then navigates to any point on command — no manual control, no pre-built maps.

## Tech Stack

| Layer | Component | Purpose |
|-------|-----------|---------|
| **Autonomy** | explore_lite | Frontier-based autonomous exploration |
| **Planning** | Nav2 + A* | Path planning and obstacle avoidance |
| **SLAM** | ORB-SLAM3 | Visual mapping and localization |
| **Middleware** | ROS 2 Humble | Inter-process communication |
| **Hardware Bridge** | spot_ros2 | Spot SDK ↔ ROS 2 interface |
| **Frontend** | Web/Mobile (roslibjs) | Dashboard for visualization and control |

## Architecture

```
[Spot Cameras] → [ORB-SLAM3] → [Nav2 + A*] → [Spot Motors]
                       ↓              ↑
                    [Map]  →  [Frontier Explorer]
                       ↓
                  [Frontend via rosbridge]
```

## Prerequisites

- **Docker Desktop** (macOS, Apple Silicon or Intel)
- **Boston Dynamics Spot** (for real hardware testing)
- **Node.js** (for frontend development)

## Quick Start

```bash
# Clone the repo
git clone https://github.com/<your-username>/spot-autonomous-nav.git
cd spot-autonomous-nav

# Start the Docker container
docker run -it --name spot_nav \
  -p 9090:9090 \
  -v $(pwd):/ros2_ws/src/spot_nav \
  osrf/ros:humble-desktop bash

# Inside the container
source /opt/ros/humble/setup.bash
```

## Project Structure

```
spot-autonomous-nav/
├── config/              # Nav2, ORB-SLAM3, explore_lite YAML configs
├── docker/              # Dockerfile and docker-compose
├── launch/              # ROS 2 launch files
├── frontend/            # Web/mobile dashboard
├── docs/                # Architecture documentation
├── scripts/             # Utility scripts
├── .gitignore
└── README.md
```

