#!/bin/sh
pushd $(dirname $0)/..
	# FIXME: hardcoded path
	mkdir -p $ROOT/$CONF
	cp -r . $ROOT/$CONF
popd
