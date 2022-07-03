{ config, lib, pkgs, ... }:

{
  imports = [
    ../common/type/headless.nix
    ../common/flakes.nix
    ../common/basic.nix
    ../common/manage-conf.nix
    ../common/services/debug-ssh.nix
    ../common/key.nix
  ];
  
  system.stateVersion = "21.11";
  networking.hostName = "installer";
}
