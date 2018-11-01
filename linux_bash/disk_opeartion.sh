#!/bin/bash

# view this website for details
# https://www.digitalocean.com/community/tutorials/how-to-partition-and-format-storage-devices-in-linux

# target disk
TAR_DISK=/dev/sda

# view disk space
lsblk

# fast format the disk to ext4 (disk format for linux system)
mkfs.ext4 -T largefile $TAR_DISK

# partition the disk - choose a partitioning standard (recommand gpt for linux)
sudo parted /dev/sda mklabel gpt

# partition the disk - create new partition
sudo parted -a opt /dev/sda mkpart primary ext4 0% 100%


