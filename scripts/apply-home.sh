#!/bin/sh
pushd ~/.conf
nix build .#homeManagerConfigurations.$USER.activationPackage
./result/activate
popd
