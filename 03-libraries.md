# OpenCV
```
wget -qO - https://raw.githubusercontent.com/milq/milq/master/scripts/bash/install-opencv.sh | bash
```

# Nvidia CUDA Toolkit 9.1
```
wget -q -o - http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_9.1.85-1_amd64.deb
sudo dpkg -i cuda-repo-ubuntu1604_9.1.85-1_amd64.deb
sudo apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub
sudo apt-get update
sudo apt-get install -y cuda
```

# SWIG
```
sudo apt install -y swig
```

# C++ 
### Yaml
```
sudo apt install -y libyaml-cpp-dev
```

### GFlags GLog
```
sudo apt install -y libgflags-dev libgoogle-glog-dev
```

### Boost
```
sudo apt install -y libboost-all-dev
```

### Curl
```
sudo apt-get install -y libpcap0.8-dev
```
