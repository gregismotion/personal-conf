#!/bin/sh
set -xeu

nixos-generate -f iso -c ./configuration.nix
