
ROOT=/setup

mkfs.ext4 -F /dev/sda1 -L root
mkdir $ROOT
mount /dev/disk/by-label/root $ROOT

mkswap /dev/sda2 -L swap
swapon /dev/disk/by-label/swap
