#!/bin/sh
set -xeu

pushd $(dirname $0)/
sudo dd if=$(./generate.sh) of=$1
popd
