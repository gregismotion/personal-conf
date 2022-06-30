{ config, pkgs, ...  }:

{
  services.sshd.enable = true;
  services.openssh = {
      enable = true;
      passwordAuthentication = false;
      permitRootLogin = false;
      challengeeResponseAuthentication = false;
      allowGroups = [ "ssh" ];
  };
}
