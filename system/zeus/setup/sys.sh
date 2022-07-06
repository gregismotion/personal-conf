#!/bin/sh

sfdisk $SYS_DISK < $PREFIX/setup/sys.dump

# NOTE: there have been problems with being too fast and partitions not being applied yet...
echo "Syncing manually..."
sync
echo "Grace period for partitions to update..."
sleep 5

BOOT_PART=${SYS_DISK}-part2
mkfs.vfat -F 32 -n boot $BOOT_PART
mkdir -p $ROOT/boot
mount $BOOT_PART $ROOT/boot

SWAP_PART=${SYS_DISK}-part3
mkswap -f -L swap $SWAP_PART
swapon $SWAP_PART

SYS_PART=${SYS_DISK}-part4
zpool create -f \
	-O compression=lz4 \
	-o ashift=12 \
	-O relatime=on \
	-O atime=off \
	-O canmount=off \
	-O mountpoint=none \
	-O dnodesize=auto \
	-O normalization=formD \
	-o autotrim=on \
	$SYS_POOL $SYS_PART

# NOTE: needed 'cos COW
zfs create -o refreservation=$RESERVED_SIZE -o mountpoint=none $SYS_POOL/reserved

zfs create $SYS_LOCAL_POOL

zfs create \
	-o xattr=sa \
	-o acltype=posixacl \
	-o mountpoint=legacy \
	-o dedup=on \
	${SYS_LOCAL_POOL}/var
mkdir -p $ROOT/var
mount -t zfs ${SYS_LOCAL_POOL}/var $ROOT/var

zfs create $SYS_SAFE_POOL
zfs set com.sun:auto-snapshot=true $SYS_SAFE_POOL
zfs create \
	-o mountpoint=legacy \
	-o dedup=on \
	${SYS_SAFE_POOL}/nix
mkdir -p $ROOT/nix
mount -t zfs ${SYS_SAFE_POOL}/nix $ROOT/nix

zfs create \
	-o mountpoint=legacy \
	-o dedup=on \
	${SYS_SAFE_POOL}/home
mkdir -p $ROOT/home
mount -t zfs ${SYS_SAFE_POOL}/home $ROOT/home

zfs create \
	-o mountpoint=legacy \
	-o dedup=on \
	${SYS_SAFE_POOL}/persist
mkdir -p $ROOT/persist
mount -t zfs ${SYS_SAFE_POOL}/persist $ROOT/persist
