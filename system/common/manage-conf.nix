{ config, pkgs, inputs, self, ...  }:

{
  imports = [ groups/conf.nix ];
  systemd.services.manage-conf = {
    script = ''
      mkdir -p /persist
      # FIXME: hardcoded paths
      if [[ ! -d "/persist/nixos/.git" ]]; then
        rm -rf /persist/nixos
        cp -r ${self}/ /persist/nixos
      fi
      cp -r ${inputs.keys}/ /persist/nixos/keys
      pushd /persist/nixos
        git init
        git remote add origin-auto https://git.freeself.one/thegergo02/personal-conf
        git remote add github-auto https://github.com/thegergo02/personal-conf
        git add .
        until curl -s -f -o /dev/null "https://nixos.org"
        do
          sleep 5
        done
        git reset --hard
        git pull --set-upstream origin-auto master
        if [[ $? != 0 ]]; then
          git pull github-auto
        fi
      popd
    '';
    description = "Manage the system configuration.";
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" ];
    wants = [ "network-online.target" "systemd-networkd-wait-online.service" ];
    serviceConfig.Type = "oneshot";
    serviceConfig.RuntimeDirectory = "/persist";
    serviceConfig.PermissionsStartOnly = "true";
    path = [ pkgs.git pkgs.curl ];
  };
}
