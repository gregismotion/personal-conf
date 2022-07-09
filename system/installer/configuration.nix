{ config, lib, pkgs, ... }:

{
  imports = [
    #./boot.nix
    ./root.nix
    ../common/installer.nix
    ../common/type/headless.nix
    ../common/flakes.nix
    ../common/basic.nix
    ../common/manage-conf.nix
    ../common/services/debug-ssh.nix
    ../common/key.nix
  ];
  
  system.stateVersion = "22.05";
  networking.hostName = "installer";
}
