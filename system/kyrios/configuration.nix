{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./boot.nix
    ./network.nix
    ./x.nix
    ./store.nix
    ./users.nix
    ./flakes.nix
    ./services/openssh.nix
  ];
  
  system.stateVersion = "21.11";
  time.timeZone = "Europe/Budapest";
}
