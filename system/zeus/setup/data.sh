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
	-o canmount=on \
	-o mountpoint=/data/torrent \
	${DATA_LOCAL_POOL}/torrent
zfs create \
	-o recordsize=1M \
	-o canmount=on \
	-o mountpoint=/data/share \
	-o dedup=on \
	${DATA_LOCAL_POOL}/share

zfs create $DATA_SAFE_POOL
zfs set com.sun:auto-snapshot=true $DATA_SAFE_POOL
zfs create \
	-o redundant_metadata=most \
	-o recordsize=16k \
	-o logbias=throughput \
	-o canmount=on \
	-o mountpoint=/data/postgres \
	${DATA_SAFE_POOL}/postgres
zfs create \
	-o recordsize=1M \
	-o canmount=on \
	-o mountpoint=/data/important \
	-o dedup=on \
	${DATA_SAFE_POOL}/important
