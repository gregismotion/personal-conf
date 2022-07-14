#!/bin/sh
pushd $(dirname $0)/..
nixos-rebuild switch --flake .#
scripts/common/fix-perms.sh .
popd
