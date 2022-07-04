#!/bin/sh
pushd $(dirname $0)
./apply-sys.sh
common/wait-until-git.sh
./apply-home.sh
popd
