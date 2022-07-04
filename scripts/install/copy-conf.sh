#!/bin/sh
pushd $(dirname $0)/..
	mkdir -p $ROOT/etc/nixos
	cp -r . $ROOT/etc/nixos
popd
