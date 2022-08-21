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
    ../common/phome-wireless.nix
    ./x.nix
    #./weylus.nix
    ./adb.nix
    ./store.nix
    ../common/users.nix
    #../common/manage-conf.nix
    ../common/services/mosh.nix
    ../common/services/syncthing-firewall.nix
    ../common/key.nix
  ];
  
  system.stateVersion = "22.05";
  time.timeZone = "Europe/Budapest";
  
  networking = { 
    hostName = "kyrios";
    interfaces.wlp0s16f1u1.useDHCP = true;
  };

  networking.extraHosts = ''
    192.168.110 zeus
  '';
}
