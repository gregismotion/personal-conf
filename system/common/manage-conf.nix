{ config, pkgs, inputs, self, ...  }:

{
  imports = [ groups/conf.nix ];
  systemd.services.manage-conf = {
    script = ''
      mkdir -p /persist

      # FIXME: hardcoded paths
      if [[ ! -d "/persist/nixos/.git" ]]; then
        rm -rf /persist/nixos
        cp -r ${self}/ nixos
      fi
      cp -r ${inputs.keys}/ /persist/nixos/keys
    '';
    description = "Manage the system configuration.";
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" ];
    wants = [ "network-online.target" "systemd-networkd-wait-online.service" ];
    serviceConfig.Type = "oneshot";
    path = [ pkgs.git pkgs.curl ];
  };
}
