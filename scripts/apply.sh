#!/bin/sh
pushd $(dirname $0)
./apply-sys.sh
./apply-home.sh
popd
