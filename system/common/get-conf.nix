{ config, pkgs, ...  }:

{
  systemd.services.get-conf = {
    script = ''
      cd /etc/
      rm -rf nixos
      git clone https://git.freeself.one/thegergo02/personal-conf
      mv personal-conf nixos
    '';
    description = "Get the system configuration.";
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" ];
    wants = [ "network-online.target" "systemd-networkd-wait-online.service" ];
    #restart = "on-failure";
    #restartSec = 5;
    #startLimitIntervalSec = 500;
    #startLimitBurst = 5;
    path = [ pkgs.git ];
  };
}
