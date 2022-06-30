#!/bin/sh
pushd ~/.conf
nix flake update
popd
