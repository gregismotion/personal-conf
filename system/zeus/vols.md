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
	- mountpoint=legacy (/var)
	- dedup=on

### saved
- nix
	- mountpoint=legacy (/nix)
	- dedup=on
- home
	- mountpoint=legacy (/home)
	- dedup=on
- persist
	- mountpoint=legacy (/persist)
	- dedup=on


# data


## not backed up
- torrent
	- recordsize=16KB
	- mountpoint=legacy (/data/torrent)
	- move to `share` as final dir
- share
	- recordsize=1M
	- mountpoint=legacy (/data/share)
	- dedup=on

## backed up
- postgres
	- redundant_metadata=most
	- recordsize=16k
	- logbias=throughput
	- mountpoint=legacy (/data/postgres)
- important
	- recordsize=1M
	- mountpoint=legacy (/data/important)
	- dedup=on

