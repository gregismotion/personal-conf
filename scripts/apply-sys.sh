#!/bin/sh
pushd $(dirname $0)/..
sudo nixos-rebuild switch --flake .#
scripts/common/fix-perms.sh
popd
