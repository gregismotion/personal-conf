#!/bin/sh
set -e

pushd $(dirname $0)/..
HOST=${1:-kyrios}
ROOT=${2:-/setup}
if [[ -d "$ROOT" ]]; then
	echo "$ROOT is created, assuming manual installation..."
	MANUAL=1
else
	echo "Missing system root, trying 'setup.sh'..."
	SETUP=system/$HOST/setup.sh
	if [[ -f "$SETUP" ]]; then
		$SETUP
		MANUAL=0
	else
		echo "No setup.sh, aborting!"
		exit 1
	fi
fi
if [[ -d "system/$HOST" ]]; then
	echo "Generating hardware-configuration.nix for $HOST..."
	HARDWARE_CONF=system/$HOST/hardware-configuration.nix
	if [[ -f "$HARDWARE_CONF" ]]; then
	rm $HARDWARE_CONF
	fi
	nixos-generate-config --root $ROOT --show-hardware-config >> system/$HOST/hardware-configuration.nix

	echo "Installing NixOS on $HOST..."
	if [[ $MANUAL != 0 ]]; then
		echo "Manual install: will be prompted for root password."
		nixos-install --root $root --flake .#$HOST
	else
		nixos-install --no-root-passwd --root $root --flake .#$HOST
	fi
	cp -r $(dirname $0)/.. $ROOT/etc/nixos
	chown -R root:conf $ROOT/etc/nixos
	chmod -R g+rwx $ROOT/etc/nixos

	# TODO: push hardware conf to repo

	echo "Don't forget to change user passwords!"
	echo "Printing users:"
	awk -F: '($3>=1000)&&($1!="nobody")&&($1!~/nixbld*/){print $1}' $ROOT/etc/passwd
	echo "Use 'passwd <user>'! (After booting into system.)"

	echo "NixOS is installed and configured on $HOST."
	echo "Veni, vidi, vici."
else
	echo "Missing host configuration!"
	exit 1
fi
popd
