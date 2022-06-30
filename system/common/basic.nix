{ config, pkgs, ...  }:

{
  environment.systemPackages = with pkgs; [
    tmux vim
    wget git
    mosh
  ];
}
