#!/bin/sh
pushd $(dirname $0)
./apply-sys.sh
until ! [ -f "../.git/index.lock" ]
do
	sleep 5
done
./apply-home.sh
popd
