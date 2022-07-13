{ config, pkgs, ... }:

{
  imports = [
    ../common/type/headless.nix
    ./hardware-configuration.nix
    ../common/flakes.nix
    ../common/basic.nix
    ../common/users.nix
    ./store.nix
    ../common/manage-conf.nix
    ../common/key.nix
  ];
  
  system.stateVersion = "22.05";
  time.timeZone = "Europe/Budapest";
  
  networking.hostName = "aphrodite";
}
