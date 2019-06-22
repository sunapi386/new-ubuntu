
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
