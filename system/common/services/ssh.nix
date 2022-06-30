{ config, pkgs, ...  }:

{
  services.sshd.enable = true;
  services.openssh = {
      enable = true;
      passwordAuthentication = false;
      permitRootLogin = false;
      challengeResponseAuthentication = false;
      extraConfig = ''
        AllowGroups ssh
      '';
  };
}
