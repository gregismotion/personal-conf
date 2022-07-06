#!/bin/sh

zpool create -f \ # FIXME: remove force in prod!!!!
	-O compression=lz4 \
	-o ashift=12 \
	-O relatime=on \
	-O atime=off \
	-O canmount=off \
	-O mountpoint=none \
	-O dnodesize=auto \
	-O normalization=formD \
	$DATA_POOL $DATA_DISK

# NOTE: needed 'cos COW
zfs create -o refreservation=$RESERVED_SIZE -o mountpoint=none $DATA_POOL/reserved

zfs create $DATA_LOCAL_POOL
zfs create \
	-o recordsize=16KB \
	-o mountpoint=legacy \
	${DATA_LOCAL_POOL}/torrent
mkdir -p $ROOT/data/torrent
mount -t zfs ${DATA_LOCAL_POOL}/torrent $ROOT/data/torrent

zfs create \
	-o recordsize=1M \
	-o mountpoint=legacy \
	-o dedup=on \
	${DATA_LOCAL_POOL}/share
mkdir -p $ROOT/data/share
mount -t zfs ${DATA_LOCAL_POOL}/share $ROOT/data/share

zfs create $DATA_SAFE_POOL
zfs set com.sun:auto-snapshot=true $DATA_SAFE_POOL
zfs create \
	-o redundant_metadata=most \
	-o recordsize=16k \
	-o logbias=throughput \
	-o mountpoint=legacy \
	${DATA_SAFE_POOL}/postgres
mkdir -p $ROOT/data/postgres
mount -t zfs ${DATA_SAFE_POOL}/postgres $ROOT/data/postgres

zfs create \
	-o recordsize=1M \
	-o mountpoint=legacy \
	-o dedup=on \
	${DATA_SAFE_POOL}/important
mkdir -p $ROOT/data/important
mount -t zfs ${DATA_SAFE_POOL}/important $ROOT/data/important
