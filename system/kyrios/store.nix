{ config, pkgs, ...  }:

{
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    tmux vim
    wget git
  ];
  nix.autoOptimiseStore = true;   
}
