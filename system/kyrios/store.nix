{ config, pkgs, ...  }:

{
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    ungoogled-chromium
    syncthing
    tmux
    wget vim git
  ];
  nix.autoOptimiseStore = true;   
}
