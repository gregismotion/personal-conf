{ config, pkgs, ... }:

{
  imports = [
    ../common/type/headless.nix
    ./hardware-configuration.nix
    ./boot.nix
    ../common/flakes.nix
    ../common/basic.nix
    ../common/manage-conf.nix
    ./store.nix
    ../common/users.nix
    ../common/key.nix
  ] ++ [
    ../common/services/minidlna.nix
    ../common/services/ssh.nix
  ];
  
  system.stateVersion = "21.11";
  time.timeZone = "Europe/Budapest";
  
  networking.hostName = "zeus";
}
