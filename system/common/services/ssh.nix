{ config, pkgs, ...  }:

{
  imports = [ ../groups/ssh.nix  ];
  services.sshd.enable = true;
  services.openssh = {
      enable = true;
      passwordAuthentication = false;
      permitRootLogin = "no";
      challengeResponseAuthentication = false;
      hostKeys = [
        {
          path = "/persist/etc/ssh/ssh_host_ed25519_key";
          type = "ed25519";
        }
        {
          path = "/persist/etc/ssh/ssh_host_rsa_key";
          type = "rsa";
          bits = 4096;
        }
      ];
      extraConfig = ''
        AllowGroups ssh
      '';
  };
}
