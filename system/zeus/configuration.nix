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
    ../common/services/mosh.nix
    
    ./services/traefik.nix
    ./services/postgresql.nix

    ../common/services/zitadel.nix

    ../common/services/gitea.nix

    ../common/services/samba.nix

    ../common/services/minidlna.nix
    ../common/services/jellyfin.nix
  ];
  
  system.stateVersion = "22.05";
  time.timeZone = "Europe/Budapest";
  
  networking.hostName = "zeus";
}
