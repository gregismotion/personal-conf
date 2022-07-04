#!/bin/sh

pushd $(dirname $0)/..
# NOTE: fix when root runs script
if [ "$UID" = "0" ] 
then
	chown -R root:conf . 
	chmod -R g+rwx .
fi
popd
