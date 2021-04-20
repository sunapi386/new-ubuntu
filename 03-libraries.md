## C++

### SWIG
```
sudo apt install swig
```

### Yaml
```
sudo apt install libyaml-cpp-dev
```

### GFlags GLog
```
sudo apt install libgflags-dev libgoogle-glog-dev
```

### Boost
```
sudo apt install libboost-all-dev
```

### Curl
```
sudo apt-get install libpcap0.8-dev
```

### SDL
```
sudo apt-get install libsdl2-dev libsdl2-gfx-dev libsdl2-image-dev libsdl2-ttf-dev
```

### Pangolin
```
sudo apt-get install libglew-dev
git clone https://github.com/stevenlovegrove/Pangolin.git
cd Pangolin
mkdir build
cd build
cmake -DBUILD_TESTS=false -DBUILD_EXAMPLES=false ..
make -j
sudo make install
```


# Install Ruby 2.3.7 - (https://gorails.com/setup/ubuntu/20.04)

```
sudo apt install -y autoconf bison build-essential libcurl4-openssl-dev libdb-dev libffi-dev libgdbm-dev libgdbm6 libncurses5-dev libreadline-dev libreadline6-dev libsqlite3-dev libssl-dev libxml2-dev libxslt1-dev libyaml-dev software-properties-common sqlite3 zlib1g-dev

git clone https://github.com/rbenv/rbenv.git ~/.rbenv

# bash
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
exec $SHELL

# fish


git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
exec $SHELL
```

Edit the file /etc/apt/sources.list and add following line to end of it (you have to do sudo vim /etc/apt/sources.list)

```
deb http://security.ubuntu.com/ubuntu bionic-security main
```

Run

```
sudo apt update && apt-cache policy libssl1.0-dev

sudo apt-get install libssl1.0-dev

rbenv install 2.3.7
rbenv global 2.3.7
ruby -v
```
Find ruby executable path - This will be something like $HOME/.rbenv/versions/2.3.7/bin/ruby



# Install JAVA 8 - (https://computingforgeeks.com/how-to-install-java-8-on-ubuntu/)
```
sudo apt install openjdk-8-jdk
sudo apt install openjdk-8-jre-headless # if on server
```
Find java8 install path

```
update-alternatives --list java
```

# Install ADB and Fastboot
```
sudo apt-get install android-tools-adb android-tools-fastboot
```

User Permissions - Add yourself to plugdev group:
```
plugdev group
sudo usermod -aG plugdev $LOGNAME
```
You have to log out and back in for the settings to take effect.

UDEV Rules - Create the file `/etc/udev/rules.d/51-android.rules` with the content below

```
# Lab126
SUBSYSTEM=="usb|usb_device", ATTRS{idVendor}=="1949", MODE="0666", GROUP="plugdev"
Restart udev daemon with
```

Restart dev
```
systemctl restart udev
```

Plug out and plug in your USB cable. You should now be able to use adb or fastboot commands.
