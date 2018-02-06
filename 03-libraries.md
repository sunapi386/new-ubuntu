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
