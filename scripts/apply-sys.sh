#!/bin/sh
pushd ~/.conf
sudo nixos-rebuild switch --flake .#
popd
