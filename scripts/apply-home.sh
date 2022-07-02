#!/bin/sh
pushd $(dirname $0)/..
if [[ ! -f "$HOME/.config/git/config" ]]; then
	git config --global --add safe.directory "$(pwd)"
fi
if [[ -d "users/$USER/" ]]; then # NOTE: fix when user has no config
	pushd users/$USER/
	if [[ $CONF_HEADLESS != 0 ]] 
	then
		ln -sf headless.nix home.nix
	else
		ln -sf gui.nix home.nix
	fi
	if [[ $USER -eq "root" ]]
	then
		chown root:conf home.nix # NOTE: fix when root runs script
		chmod g+rwx home.nix # NOTE: fix when root runs script
	fi
	popd
	nix build .#homeManagerConfigurations.$USER.activationPackage
	./result/activate
fi
popd
