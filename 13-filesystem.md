# filesystems

## apple hfs
```bash
sudo apt-get install hfsprogs
sudo fsck.hfsplus -f /dev/sda2
sudo mkdir /media/sda2
sudo mount -t hfsplus -o force,rw /dev/sda2 /media/sda2
```


## EXFAT

```
sudo apt update
sudo apt install -y exfat-fuse exfat-utils
```
## XFS
```bash
sudo apt install xfsprogs
sudo modprobe -v xfs
mkfs.xfs /dev/sda2 -f
# fstab
# /dev/sda2   	/mnt/data	xfs   	defaults    	0   	0

```
