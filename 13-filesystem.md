# filesystems

apple hfs
```bash
sudo apt-get install hfsprogs
sudo fsck.hfsplus -f /dev/sda2
sudo mkdir /media/sda2
sudo mount -t hfsplus -o force,rw /dev/sda2 /media/sda2
```
