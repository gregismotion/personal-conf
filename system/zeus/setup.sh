
ROOT=/setup

mkfs.ext4 /dev/sda1 -L root
mkdir /mnt
mount /dev/disk/by-label/root $ROOT

mkswap /dev/sda2 -L swap
swapon /dev/disk/by-label/swap
