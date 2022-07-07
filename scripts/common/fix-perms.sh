#!/bin/sh

# FIXME: hardcoded paths
# needed cos installer...
pushd $1
# NOTE: fix when root runs script
if [ "$UID" = "0" ] 
then
	chown -R root:conf . 
	chmod -R g+rwx .
fi
popd
