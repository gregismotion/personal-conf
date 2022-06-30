{ config, pkgs, ...  }:

{
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    ungoogled-chromium
    syncthing
    bspwm sxhkd rofi maim
    alacritty tmux
    wget vim git
    keepassxc
  ];
  nix.autoOptimiseStore = true;   
}
