{ config, pkgs, ...  }:

{
  nixpkgs.config.allowUnfree = true;
  nix.autoOptimiseStore = true;   
}
