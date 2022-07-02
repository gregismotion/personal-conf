#!/bin/sh
set -e

pushd $(dirname $0)/..
HOST=${1:-kyrios}
ROOT=${2:-/setup}
if [[ -d "$ROOT" ]]; then
	echo "$ROOT is created, assuming manual installation..."
else
	echo "Missing system root, trying 'setup.sh'."
	SETUP=system/$HOST/setup.sh
	if [[ -f "$SETUP" ]]; then
		echo "Running '$SETUP'..."
		$SETUP
	else
		echo "No setup.sh, aborting!"
		exit 1
	fi
fi
if [[ -d "system/$HOST" ]]; then
	echo "Generating hardware-configuration.nix for $HOST."
	HARDWARE_CONF=system/$HOST/hardware-configuration.nix
	if [[ -f "$HARDWARE_CONF" ]]; then
	rm $HARDWARE_CONF
	fi
	nixos-generate-config --root $ROOT --show-hardware-config >> system/$HOST/hardware-configuration.nix

	echo "Installing NixOS on $HOST..."
	nixos-install --root $root --flake .#$HOST
	
	echo "Fixing permissions on config directory."
	cp -r $(dirname $0)/.. $ROOT/etc/nixos
	chown -R root:conf $ROOT/etc/nixos
	chmod -R g+rwx $ROOT/etc/nixos

	# TODO: push hardware conf to repo

	echo "NixOS is installed and configured on $HOST."
	echo "Veni, vidi, vici."
else
	echo "Missing host configuration!"
	exit 1
fi
popd
