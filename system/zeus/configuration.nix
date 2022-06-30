{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./boot.nix
    ../common/flakes.nix
    ../common/basic.nix
    ./store.nix
    ./users.nix
  ] ++ [
    ./services/minidlna.nix
  ];
  
  system.stateVersion = "21.11";
  time.timeZone = "Europe/Budapest";

  networking.hostName = "zeus";
}
