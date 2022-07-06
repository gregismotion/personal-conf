# tmpfs
- root

# ZFS

- compression=lz4
- ashift=12
- relatime=on
- atime=off
- canmount=off
- mountpoint=none
- dnodesize=auto
- normalization=formD

## sys
- autotrim=on

### erased on boot
- var
	- xattr=sa
	- acltype=posixacl
	- canmount=on
	- mountpoint=/var
	- dedup=on
- swap
	- compression=no

### saved
- nix
	- canmount=on
	- mountpoint=/nix
	- dedup=on
- home
	- canmount=on
	- mountpoint=/home
	- dedup=on
- persist
	- canmount=on
	- mountpoint=/persist
	- dedup=on


# data


## not backed up
- torrent
	- recordsize=16KB
	- canmount=on
	- mountpoint=/data/torrent
	- move to `share` as final dir
- share
	- recordsize=1M
	- canmount=on
	- mountpoint=/data/share
	- dedup=on

## backed up
- postgres
	- redundant_metadata=most
	- recordsize=16k
	- logbias=throughput
	- canmount=on
	- mountpoint=/data/postgres
- important
	- recordsize=1M
	- canmount=on
	- mountpoint=/data/important
	- dedup=on

