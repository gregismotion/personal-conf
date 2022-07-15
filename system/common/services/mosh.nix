{ config, pkgs, ...  }:

{
  imports = [ ./ssh.nix  ];
  programs.mosh.enable = true;
}
