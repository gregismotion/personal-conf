{ config, pkgs, ...  }:

{
  services.sshd.enable = true;
  services.openssh = {
      enable = true;
      passwordAuthentication = false;
      permitRootLogin = "no";
      challengeResponseAuthentication = false;
      extraConfig = ''
        AllowGroups ssh
      '';
  };
}
