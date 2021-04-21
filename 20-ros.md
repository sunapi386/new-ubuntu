# ROS Melodic Desktop Full

http://wiki.ros.org/melodic/Installation/Ubuntu

```
# sources.list
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'

# keys
sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
curl -sSL 'http://keyserver.ubuntu.com/pks/lookup?op=get&search=0xC1CF6E31E6BADE8868B172B4F42ED6FBAB17C654' | sudo apt-key add -

# install
sudo apt-get update
sudo apt-get install -y ros-melodic-desktop-full

# env (fish shell)
bass source /opt/ros/melodic/setup.bash

# compiling deps
sudo apt install -y python-rosdep python-rosinstall python-rosinstall-generator python-wstool build-essential
sudo rosdep init
rosdep update

```

Build just one package using `catkin_make`

```
sudo apt install -y install python-catkin-tools

# Build specific package
catkin build <target_package>

# Build the package from a directory under the package root
catkin build --this
```
