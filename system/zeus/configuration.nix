{ config, pkgs, ... }:

{
  imports = [
    ../common/type/headless.nix
    ./storage.nix
    ./hardware-configuration.nix
    ./boot.nix
    ../common/flakes.nix
    ../common/basic.nix
    ../common/manage-conf.nix
    ./store.nix
    ../common/users.nix
    ../common/key.nix
    ./firewall.nix
  ] ++ [
    ../common/services/ssh.nix

    ../common/services/zitadel.nix

    #../common/services/samba.nix

    ../common/services/minidlna.nix
  ];
  
  system.stateVersion = "21.11";
  time.timeZone = "Europe/Budapest";
  
  networking.hostName = "zeus";
}
