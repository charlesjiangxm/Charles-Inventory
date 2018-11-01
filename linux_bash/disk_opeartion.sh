#!/bin/bash

# view this website for details
# https://www.digitalocean.com/community/tutorials/how-to-partition-and-format-storage-devices-in-linux

# target disk
TAR_DISK=/dev/sdc
TAR_DISK_PARTITION=$TAR_DISK'1'
YOUR_DISK_DIR=/mnt/disk/disk-3

# view disk space
lsblk

# fast format the disk to ext4 (disk format for linux system)
mkfs.ext4 -T largefile $TAR_DISK

# partition the disk - choose a partitioning standard (recommand gpt for linux)
sudo parted /dev/sda mklabel gpt

# partition the disk - create new partition
sudo parted -a opt $TAR_DISK mkpart primary ext4 0% 100%

# create a file system
sudo mkfs.ext4 -L datapartition $TAR_DISK_PARTITION

# check if partition and create file system is success, get the UUID
sudo lsblk --fs 

# mount temporarily
sudo mkdir -p $YOUR_DISK_DIR
sudo mount -o defaults $TAR_DISK_PARTITION $YOUR_DISK_DIR

# mounting the file system automatically at boot
sudo vim /etc/fstab/

# append this to the end
# UUID=xxxxxxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx /mnt/disks/disk-3 ext4 defaults 0 2 