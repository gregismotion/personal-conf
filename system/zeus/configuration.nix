{ config, pkgs, ... }:

{
  imports = [
    ../common/type/headless.nix
    ./hardware-configuration.nix
    ./boot.nix
    ../common/flakes.nix
    ../common/basic.nix
    ../common/get-conf.nix
    ../common/apply-conf.nix
    ./store.nix
    ./users.nix
  ] ++ [
    ../common/services/minidlna.nix
    ../common/services/ssh.nix
  ];
  
  system.stateVersion = "21.11";
  time.timeZone = "Europe/Budapest";
  
  networking.hostName = "zeus";
}
