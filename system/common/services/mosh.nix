{ config, pkgs, ...  }:

{
  imports = [ ./ssh.nix  ];
  services.mosh.enable = true;
}
