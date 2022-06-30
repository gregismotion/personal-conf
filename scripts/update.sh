#!/bin/sh
pushd $(dirname $0)/..
nix flake update
popd
