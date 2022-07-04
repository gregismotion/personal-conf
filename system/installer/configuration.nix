{ config, lib, pkgs, ... }:

{
  imports = [
    ./root.nix
    ../common/installer.nix
    ../common/type/headless.nix
    ../common/flakes.nix
    ../common/basic.nix
    ../common/manage-conf.nix
    ../common/services/debug-ssh.nix
    ../common/key.nix
  ];
  
  system.stateVersion = "21.11";
  networking.hostName = "installer";
  boot.loader.timeout = lib.mkForce 0;
}
