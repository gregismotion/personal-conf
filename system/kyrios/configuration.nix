{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./boot.nix
    ../common/flakes.nix
    ./network.nix
    ./x.nix
    ./nvidia.nix
    ./store.nix
    ./users.nix
    ./services/openssh.nix
  ];
  
  system.stateVersion = "21.11";
  time.timeZone = "Europe/Budapest";
  networking.hostName = "kyrios";
}
