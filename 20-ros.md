# Build ROS Kinetic Desktop Full from upstream source

```
sudo apt-get -y install python-rosdep python-rosinstall-generator python-wstool python-rosinstall build-essential
mkdir ~/ros_catkin_ws
cd ~/ros_catkin_ws
rosinstall_generator desktop_full --rosdistro kinetic --deps --wet-only --tar > kinetic-desktop-full-wet.rosinstall
wstool init -j8 src kinetic-desktop-full-wet.rosinstall
rosdep install --from-paths src --ignore-src --rosdistro kinetic -y
./src/catkin/bin/catkin_make_isolated --install -DCMAKE_BUILD_TYPE=Release
```

# Build ROS Kinetic rviz from upstream source
For people that just need to use rviz, and don't need to use full desktop version:

```
sudo apt-get install python-rosdep python-rosinstall-generator python-wstool python-rosinstall build-essential
mkdir ~/rviz_catkin_ws
cd ~/rviz_catkin_ws
rosinstall_generator rviz --rosdistro kinetic --deps --wet-only --tar > kinetic-desktop-rviz-wet.rosinstall
wstool init -j8 src kinetic-desktop-rviz-wet.rosinstall
rosdep install --from-paths src --ignore-src --rosdistro kinetic -y
./src/catkin/bin/catkin_make_isolated --install -DCMAKE_BUILD_TYPE=Release
```
