#!/bin/sh
set -xeu

pushd $(dirname $0)/..
HOST=${1:-kyrios}
ROOT=${2:-/mnt}
echo "Generating hardware-configuration.nix for $HOST..."
nixos-generate-config --root $ROOT --dir $(dirname $0)/../system/$HOST/.
echo "Installing NixOS on $HOST..."
nixos-install --root $ROOT --flake .#$HOST
echo "Don't forget to change user passwords!"
echo "Printing users:"
awk -F: '($3>=1000)&&($1!="nobody")&&($1!~/nixbld*/){print $1}' $ROOT/etc/passwd
echo "Use 'passwd <user>'!"
echo "NixOS is installed and configured on $HOST."
echo "Veni, vidi, vici."
popd
