# update nvidia drivers
```
sudo apt purge "nvidia*"
sudo add-apt-repository ppa:graphics-drivers
sudo apt update
sudo apt install -y nvidia-settings
# sudo apt install nvidia-390 # as of Jan 31 2018
sudo apt install nvidia-430 # as of Jun 13 2019
```

# If LightDM doesn't play nicely
nvidia-430 isn't supported in lightdm at the moment. You may want to go back and install again.
```
sudo vim /etc/default/grub # to change "quiet splash" to "quiet nosplash"
sudo update-grub
reboot
(Press ESC)
Select ubuntu recovery mode, enable networking, then root terminal.
sudo add-apt-repository ppa:graphics-drivers (if you haven't already)
sudo apt purge nvidia* (if you tried installing already)
sudo apt install nvidia-418 (nvidia-430 doesn't work with lightdm yet)
You may need to sudo systemctl stop lightdm
nvidia-smi (check your version is correct)
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


# Nvidia CUDA
Version 9 introduces API changes. Tensorflow doesn't support 9 yet (Feb 3, 2018).

```
# version 8
wget -q -o - http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_8.0.61-1_amd64.deb
sudo dpkg -i cuda-repo-ubuntu1604_8.0.61-1_amd64.deb
sudo apt-get install cuda

# version 9
wget -q -o - http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_9.1.85-1_amd64.deb
sudo dpkg -i cuda-repo-ubuntu1604_9.1.85-1_amd64.deb
sudo apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub
sudo apt-get update
sudo apt-get install cuda
```
I had installed 9 and needed to purge and install 8.
http://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html#package-manager-additional
```
sudo apt autoremove cuda
sudo apt-get install cuda-8-0
```


## cuDNN

https://developer.nvidia.com/rdp/cudnn-download

Installing from deb file is easier, both:

- cuDNN v7.0.5 Runtime Library for Ubuntu16.04 (Deb)
- cuDNN v7.0.5 Developer Library for Ubuntu16.04 (Deb)

```
tar -xvzf cudnn-8.0-linux-x64-v7.tgz
sudo cp cuda/include/cudnn.h /usr/local/cuda/include
sudo cp cuda/lib64/libcudnn* /usr/local/cuda/lib64
sudo chmod a+r /usr/local/cuda/include/cudnn.h
# /usr/local/cuda/lib64/libcudnn*
```
