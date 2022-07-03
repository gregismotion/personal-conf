{ config, pkgs, lib, ...  }:

{
  services.sshd.enable = true;
  services.openssh.permitRootLogin = lib.mkDefault "yes";
}
