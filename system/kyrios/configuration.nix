{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../common/nvidia-legacy390.nix
    ./boot.nix
    ../common/flakes.nix
    ../common/basic.nix
    ../../secrets/age.nix
    ./phome-wireless.nix
    ./x.nix
    ./store.nix
    ./users.nix
  ];
  
  system.stateVersion = "21.11";
  time.timeZone = "Europe/Budapest";

  networking = { 
    hostName = "kyrios";
    interfaces.wlp0s16f1u1.useDHCP = true;
  };
}
