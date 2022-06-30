{ config, pkgs, lib, ...  }:

{
  services.sshd.enable = true;
  services.openssh.permitRootLogin = lib.mkDefault "yes";

  users.users.root.password = "nixos";
  services.getty.autologinUser = lib.mkDefault "root";
}
