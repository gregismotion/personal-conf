#!/bin/sh
pushd $(dirname $0)/..

HOST=${1:-kyrios}
ROOT=${2:-/setup}

echo "Applying home for $USER..."
scripts/apply-home.sh

echo "Setting up $HOST..."
source scripts/install/setup.sh

if [[ -d "system/$HOST" ]]; then
	echo "Generating hardware-configuration.nix for $HOST."
	scripts/install/generate-hardware-conf.sh
	
	echo "Copying configuration to $ROOT..."
	scripts/install/copy-conf.sh

	echo "Installing NixOS on $HOST..."
	scripts/install/install.sh
	
	echo "Fixing permissions on config directory."
	$ROOT/etc/nixos/scripts/common/fix-perms.sh
	
	echo "Pushing new hardware configuration..."
	scripts/install/push-hardware-conf.sh
	
	echo "NixOS is installed and configured on $HOST."
	echo "Veni, vidi, vici."
else
	echo "Missing host configuration for $HOST!"
	exit 1
fi
popd
