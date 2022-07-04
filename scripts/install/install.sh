#!/bin/sh
pushd $(dirname $0)/..
	nixos-install --no-root-passwd --root $ROOT --flake .#$HOST
popd
