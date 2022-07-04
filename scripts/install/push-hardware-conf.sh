#!/bin/sh
pushd $(dirname $0)/..
	git add $HARDWARE_CONF
	git commit -m "add: new $HOST configuration (automation)"
	git push
popd
