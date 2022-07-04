#!/bin/sh

pushd $(dirname $0)/../..
if [[ -d "$ROOT" ]]; then
	echo "$ROOT is created, assuming manual installation..."
else
	echo "Missing system root, trying 'setup.sh'."
	SETUP=system/$HOST/setup.sh
	if [[ -f "$SETUP" ]]; then
		echo "Running '$SETUP'..."
		source $SETUP
	else
		echo "No setup.sh for $HOST, aborting!"
		exit 1
	fi
fi
popd
