#!/bin/sh
set -e

pushd $(dirname $0)/..
HOST=${1:-kyrios}
ROOT=${2:-/mnt}
if [[ -d "$ROOT" ]]; then
	if [[ -d "system/$HOST" ]]; then
		echo "Generating hardware-configuration.nix for $HOST..."
		HARDWARE_CONF=system/$HOST/hardware-configuration.nix
		if [[ -f "$HARDWARE_CONF" ]]; then
			rm $HARDWARE_CONF
		fi
		nixos-generate-config --root $ROOT --show-hardware-config >> system/$HOST/hardware-configuration.nix

		echo "Installing NixOS on $HOST..."
		nixos-install --root $ROOT --flake .#$HOST
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
	fi
else
	echo "Missing system root!"
fi
popd
