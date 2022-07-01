{ config, pkgs, ...  }:

{
  imports = [ ../groups/ssh.nix  ];
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
