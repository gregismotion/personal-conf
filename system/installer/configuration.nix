{ config, lib, pkgs, ... }:

{
  imports = [
    ../common/flakes.nix
    ../common/basic.nix
    ../common/get-conf.nix
    ../common/services/debug-ssh.nix
  ];
  
  system.stateVersion = "21.11";
}
