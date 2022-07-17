{ config, pkgs, ... }:

{
  programs.weylus = {
    enable = true;
    openFirewall = true;
    users = [ "thegergo02" ];
  };
}
