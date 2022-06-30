#!/bin/sh
pushd ~/.conf/scripts
./apply-sys.sh
./apply-home.sh
popd
