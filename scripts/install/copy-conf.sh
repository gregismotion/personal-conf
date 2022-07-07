#!/bin/sh
pushd $(dirname $0)/..
	# FIXME: hardcoded path
	mkdir -p $ROOT/persist/nixos
	cp -r . $ROOT/persist/nixos
popd
