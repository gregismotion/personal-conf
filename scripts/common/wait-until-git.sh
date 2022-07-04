#!/bin/sh
pushd $(dirname $0)/..
until ! [ -f ".git/index.lock" ]
do
	sleep 5
done
popd
