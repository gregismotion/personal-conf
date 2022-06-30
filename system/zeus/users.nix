{ config, pkgs, ... }:

{
  users.defaultUserShell = pkgs.zsh;
  users.users.thegergo02 = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };
}
