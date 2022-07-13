{ config, pkgs, ... }:

{
  imports = [
    ../common/type/headless.nix
    ./hardware-configuration.nix
    ../common/flakes.nix
    ../common/basic.nix
    ../common/users.nix
    ../common/manage-conf.nix
    ../common/key.nix
    ../common/hardware/rpi4-gpu.nix
  ];
  
  system.stateVersion = "22.05";
  time.timeZone = "Europe/Budapest";
  
  networking.hostName = "aphrodite";

  imports = ["${fetchTarball "https://github.com/NixOS/nixos-hardware/archive/936e4649098d6a5e0762058cb7687be1b2d90550.tar.gz" }/raspberry-pi/4"];
}
