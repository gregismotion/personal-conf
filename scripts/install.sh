#!/bin/sh
pushd $(dirname $0)/..

HOST=${1:-zeus}
ROOT=${2:-/setup}
CONF=${3:-/etc/nixos}

echo "Applying home for $USER..."
scripts/apply-home.sh

echo "Setting up $HOST on $ROOT..."
source scripts/install/setup.sh

if [[ -d "system/$HOST" ]]; then
	echo "Generating hardware-configuration.nix for $HOST."
	source scripts/install/generate-hardware-conf.sh
	
	echo "Checking EDIT_AFTER_HARDWARE_CONF variable..."
	source scripts/install/edit-after-hardware-conf.sh
	
	echo "Copying configuration to $ROOT..."
	source scripts/install/copy-conf.sh

	echo "Installing NixOS on $HOST..."
	source scripts/install/install.sh

	echo "Running post-install hook..."
	source scripts/install/post-install.sh
	
	# FIXME: hardcoded path
	echo "Fixing permissions on config directory."
	$ROOT/$CONF/scripts/common/fix-perms.sh $ROOT/$CONF
	
	echo "Pushing new hardware configuration..."
	source scripts/install/push-hardware-conf.sh
	
	echo "NixOS is installed and configured on $HOST."
	echo "Veni, vidi, vici."
else
	echo "Missing host configuration for $HOST!"
	exit 1
fi
popd
