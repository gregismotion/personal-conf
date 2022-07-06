#!/bin/sh
set -xeu

nix run github:nix-community/nixos-generators -- --flake ../../.#installer -f install-iso
