{ config, pkgs, ...  }:

{
  systemd.services.get-conf = {
    script = "/etc/nixos/scripts/apply-sys.sh";
    description = "Apply the system configuration.";
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" "get-conf.service" ];
    wants = [ "network-online.target" "systemd-networkd-wait-online.service" ];
    serviceConfig.Type = "oneshot";
  };
}
