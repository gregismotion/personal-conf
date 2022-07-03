#!/bin/sh
set -e

pushd $(dirname $0)/..
HOST=${1:-kyrios}
ROOT=${2:-/setup}

# TODO: put it in better place
# NOTE: ensure private flake's key
pushd $HOME
mkdir -p .ssh
echo '''
Host freeself
	User git
	IdentityFile /etc/ssh/id_rsa
	HostName git.freeself.one
	StrictHostKeyChecking no # NOTE: not needed here
''' >> .ssh/config
popd

if [[ -d "$ROOT" ]]; then
	echo "$ROOT is created, assuming manual installation..."
else
	echo "Missing system root, trying 'setup.sh'."
	SETUP=system/$HOST/setup.sh
	if [[ -f "$SETUP" ]]; then
		echo "Running '$SETUP'..."
		source $SETUP
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
	nixos-generate-config --root $ROOT --show-hardware-config >> $HARDWARE_CONF

	echo "Installing NixOS on $HOST..."
	nixos-install --no-root-passwd --root $ROOT --flake .#$HOST
	
	echo "Fixing permissions on config directory."
	cp -r $(dirname $0)/.. $ROOT/etc/nixos
	chown -R root:conf $ROOT/etc/nixos
	chmod -R g+rwx $ROOT/etc/nixos
	
	git add $HARDWARE_CONF
	git commit -m "add: new $HOST configuration (automation)"
	git push

	echo "NixOS is installed and configured on $HOST."
	echo "Veni, vidi, vici."
else
	echo "Missing host configuration!"
	exit 1
fi
popd
