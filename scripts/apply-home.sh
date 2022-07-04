#!/bin/sh
pushd $(dirname $0)/..

# NOTE: setup safe dir if first run
if [[ ! -f "$HOME/.config/git/config" ]]; then
	git config --global --add safe.directory "$(pwd)"
fi

if [[ -d "users/$USER/" ]]; then # NOTE: fix when user has no config
	scripts/switch-home.sh
	nix build .#homeManagerConfigurations.$USER.activationPackage
	./result/activate
fi

# NOTE: fix when root runs script
if [ "$UID" = "0" ] 
then
	chown -R root:conf . 
	chmod -R g+rwx .
fi
popd
