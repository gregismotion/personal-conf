#!/bin/sh
pushd $(dirname $0)/../..
	HARDWARE_CONF=system/$HOST/hardware-configuration.nix
	if [[ -f "$HARDWARE_CONF" ]]; then
		rm $HARDWARE_CONF
	fi
	nixos-generate-config --root $ROOT --show-hardware-config >> $HARDWARE_CONF
popd
