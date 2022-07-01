#!/bin/sh
set -e

pushd $(dirname $0)/..
HOST=${1:-kyrios}
ROOT=${2:-/mnt}
echo "Generating hardware-configuration.nix for $HOST..."
nixos-generate-config --root $ROOT --show-hardware-config >> system/$HOST/hardware-configuration.nix
echo "Installing NixOS on $HOST..."
nixos-install --root $ROOT --flake .#$HOST
cp -r $(dirname $0)/.. /mnt/etc/nixos
chmod -R 755 /mnt/etc/nixos
chown -R root:conf /mnt/etc/nixos
# TODO: push hardware conf to repo
echo "Don't forget to change user passwords!"
echo "Printing users:"
awk -F: '($3>=1000)&&($1!="nobody")&&($1!~/nixbld*/){print $1}' $ROOT/etc/passwd
echo "Use 'passwd <user>'! (After booting into system.)"
echo "NixOS is installed and configured on $HOST."
echo "Veni, vidi, vici."
popd
