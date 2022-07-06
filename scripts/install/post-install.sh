#!/bin/sh

pushd $(dirname $0)/..
	POST_INSTALL=system/$HOST/post-install.sh
	if [[ -f "$POST_INSTALL" ]]; then
		echo "Running '$POST_INSTALL'..."
		source $POST_INSTALL
	else
		echo "No post-install for $HOST, continuing..."
	fi
popd
