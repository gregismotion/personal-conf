#!/bin/sh
pushd $(dirname $0)/..
pushd users/$USER/
if [[ $CONF_HEADLESS != 0 ]] 
then
	ln -sf headless.nix home.nix
else
	ln -sf gui.nix home.nix
fi
popd
nix build .#homeManagerConfigurations.$USER.activationPackage
./result/activate
popd
