{ config, pkgs, ...  }:

{
  imports = [ groups/conf.nix ];
  systemd.services.manage-conf = {
    script = ''
      cd /etc/

      if test -d "/etc/nixos/.git"; then
        cd /etc/nixos
        git pull
      else
        rm -rf nixos
        git clone https://git.freeself.one/thegergo02/personal-conf
        mv personal-conf nixos
      fi

      pushd /etc/nixos
      HARDWARE_CONF=/etc/hardware-configuration.nix
      if test -f "$HARDWARE_CONF"; then
        mv -n $HARDWARE_CONF ./system/$HOST/.
        rm $HARDWARE_CONF
      fi
      # TODO: git push
      # TODO: apply somewhere (but installer does not need it for example)
      chown -R root:conf .
      chmod -R g+w .
      popd
    '';
    description = "Get the system configuration.";
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" ];
    wants = [ "network-online.target" "systemd-networkd-wait-online.service" ];
    /*serviceConfig.Restart = "on-failure";
    serviceConfig.RestartSec = 5;
    serviceConfig.StartLimitIntervalSec = 500;
    serviceConfig.StartLimitBurst = 5;*/
    serviceConfig.Type = "oneshot";
    path = [ pkgs.git ];
  };
}
