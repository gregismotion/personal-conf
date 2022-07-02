{ config, pkgs, ... }:

{
  imports = [
    ../common/type/gui.nix
    ./hardware-configuration.nix
    ../common/hardware/nvidia-legacy390.nix
    ../common/hardware/rtl88x2bu.nix
    ./boot.nix
    ../common/flakes.nix
    ../common/basic.nix
    ./phome-wireless.nix
    ./x.nix
    ./store.nix
    ../common/users.nix
    ../common/manage-conf.nix
    ../common/services/ssh.nix
  ];
  
  system.stateVersion = "21.11";
  time.timeZone = "Europe/Budapest";
  
  networking = { 
    hostName = "kyrios";
    interfaces.wlp0s16f1u1.useDHCP = true;
  };
}
