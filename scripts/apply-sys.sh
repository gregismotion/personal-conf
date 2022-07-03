#!/bin/sh
pushd $(dirname $0)/..
sudo nixos-rebuild switch --flake .#
sudo chmod -R g+rwx .
sudo chown -R root:conf
popd
