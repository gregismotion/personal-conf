#!/bin/sh
pushd $(dirname $0)/..
nix build .#homeManagerConfigurations.$USER.activationPackage
./result/activate
popd
