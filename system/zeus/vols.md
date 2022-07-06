# vfat
- boot

# tmpfs
- root

# ZFS

- compression=lz4
- ashift=12
- relatime=on

## sys

### erased on boot
- var
- swap

### saved
- nix
- home
- persist


# data

## not backed up
- torrent
	- recordsize=16KB
	- move to `share` as final dir
- share
	- recordsize=1M

## backed up
- postgres
	- redundant_metadata=most
	- recordsize=8K
	- logbias=throughput
- important
	- recordsize=1M

