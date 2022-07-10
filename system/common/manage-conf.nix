{ config, pkgs, inputs, self, ...  }:

{
  imports = [ groups/conf.nix ];
  systemd.services.manage-conf = {
    script = ''
      CONF=/etc/nixos
      mkdir -p $CONF
      if [[ ! -d "$CONF/.git" ]]; then
        rm -rf $CONF
        cp -r ${self}/ $CONF
      fi
      mkdir -p /persist
      cp -r ${inputs.keys}/ /persist/keys
      chmod -R 600 /persist/keys
      pushd $CONF
        git init
        git remote add origin-auto https://git.freeself.one/thegergo02/personal-conf || echo ignore failure
        git remote add github-auto https://github.com/thegergo02/personal-conf || echo ignore failure
        git add .
        until curl -s -f -o /dev/null "https://nixos.org"
        do
          sleep 5
        done
        git reset --hard
        git pull --set-upstream origin-auto master || echo ignore failure
        git pull github-auto master
      popd
    '';
    description = "Manage the system configuration.";
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" ];
    wants = [ "network-online.target" "systemd-networkd-wait-online.service" ];
    serviceConfig.Type = "oneshot";
    serviceConfig.RuntimeDirectory = "/etc"; # FIXME: hardcoded paths
    serviceConfig.PermissionsStartOnly = "true";
    path = [ pkgs.git pkgs.curl ];
  };
}
