# ROS Kinetic Desktop Full

http://wiki.ros.org/kinetic/Installation/Ubuntu

```
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
sudo apt-get update
sudo apt-get install ros-kinetic-desktop-full
```

Build just one package using catkin_make

```
sudo apt-get install python-catkin-tools

# Build specific package
catkin build <target_package>

# Build the package from a directory under the package root
catkin build --this
```
