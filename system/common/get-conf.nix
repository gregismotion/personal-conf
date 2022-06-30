{ config, pkgs, ...  }:

{
  systemd.services.get-conf = {
    script = ''
      cd /etc/
      rm -rf nixos
      git clone https://git.freeself.one/thegergo02/personal-conf
      mv personal-conf nixos
    '';
    wantedBy = [ "multi-user.target" "network-online.target" ];
    path = [ pkgs.git ];
  };
}
