#!/bin/sh
pushd $(dirname $0)
./apply-sys.sh
./wait-until-git.sh
./apply-home.sh
popd
