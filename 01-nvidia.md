# update nvidia drivers
```
sudo apt purge "nvidia*"
sudo add-apt-repository ppa:graphics-drivers
sudo apt update
sudo apt install nvidia-390 # as of Jan 31 
```
# Reboot, check for success
```
lsmod | grep nvidia
```
If there is no output, then your installation has probably failed. 
It is also possible that the driver is not available in your system's driver database. 
Check if your system is running on the open source driver nouveau. 
If the output is negative for nouveau, then all is well with your installation.
```
lsmod | grep nouveau
```

Prevent automatic updates that might break the drivers. You can do this in 2 ways
  a. By removing the graphics-drivers PPA from your software sourcesThis will depend on your distro. On Ubuntu, go to your software sources, and then other sources and remove all instances of the graphics-driver PPAs.
  b. Or by blocking minor version updates. Enter the following command
```
sudo apt-mark hold nvidia-390
```

# Removal

​Are you running into issues with the new drivers, you can easily remove it.
       a. Remove the graphics-drivers PPA as indicated in the step above.
       b. Enter the following command to completely remove the driver
sudo apt-get purge nvidia*
       c. Reboot your PC for the open-source nouveau drivers to kick-in.
       
Reference: http://www.linuxandubuntu.com/home/how-to-install-latest-nvidia-drivers-in-linux
