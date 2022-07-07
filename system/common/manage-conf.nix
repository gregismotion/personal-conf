{ config, pkgs, inputs, self, ...  }:

{
  imports = [ groups/conf.nix ];
  systemd.services.manage-conf = {
    script = ''
      mkdir -p /persist/nixos

      # FIXME: hardcoded paths
      if [[ ! -d "/persist/nixos/.git" ]]; then
        rm -rf /persist/nixos
        cp -r ${self}/ nixos
      fi
      cp -r ${inputs.keys}/ /persist/nixos/keys
      pushd /persist/nixos
        #git init
        #git remote add origin https://git.freeself.one/thegergo02/personal-conf
        #git remote add github https://github.com/thegergo02/personal-conf
        git add .
        until curl -s -f -o /dev/null "https://nixos.org"
        do
          sleep 5
        done
        git reset --hard
        git pull -f --set-upstream origin master
        if [[ $? != 0 ]]; then
          git pull -f github
        fi
      popd
    '';
    description = "Manage the system configuration.";
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" ];
    wants = [ "network-online.target" "systemd-networkd-wait-online.service" ];
    serviceConfig.Type = "oneshot";
    serviceConfig.WorkingDirectory = "/persist";
    path = [ pkgs.git pkgs.curl ];
  };
}
