# OpenCV
OpenCV2
```
wget -qO - https://gist.githubusercontent.com/arthurbeggs/06df46af94af7f261513934e56103b30/raw/326d831cee62270ae3b11d7c91cdeffcad901ace/install_opencv2_ubuntu.sh | bash
```
OpenCV3
```
wget -qO - https://raw.githubusercontent.com/milq/milq/master/scripts/bash/install-opencv.sh | bash
```

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

### SSD
```
git clone https://github.com/weiliu89/caffe.git
cd caffe
git checkout ssd
sudo apt-get install libprotobuf-dev libleveldb-dev libsnappy-dev libhdf5-serial-dev protobuf-compiler liblmdb-dev libatlas-base-dev libncurses-dev
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=/usr/local ..
make all -j
sudo make install

```


# Darknet
Darknet is pretty awesome.
```
git clone https://github.com/pjreddie/darknet.git
make
```
To make some horrible pictures:
```
wget http://pjreddie.com/media/files/vgg-conv.weights
./darknet nightmare cfg/vgg-conv.cfg vgg-conv.weights data/scream.jpg 10
```
To do YOLO detection:
```
# get pretrained weights
wget https://pjreddie.com/media/files/yolo.weights
./darknet detect cfg/yolo.cfg yolo.weights data/dog.jpg
```