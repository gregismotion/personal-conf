{ config, lib, pkgs, ... }:

{
  imports = [
    ../common/flakes.nix
    ../common/basic.nix
    ../common/get-conf.nix
    ../common/debug-ssh.nix
  ];
  
  system.stateVersion = "21.11";
}
