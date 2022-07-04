#!/bin/sh
pushd $(dirname $0)/../..
	mkdir -p $ROOT/etc/nixos
	cp -r $(dirname $0)/../.. $ROOT/etc/nixos
popd
