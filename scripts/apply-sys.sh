#!/bin/sh
pushd $(dirname $0)/..
sudo nixos-rebuild switch --flake .#
chmod -R g+rwx .
chown -R root:conf
popd
