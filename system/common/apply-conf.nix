{ config, pkgs, ...  }:

{
  systemd.services.get-conf = {
    script = "/etc/nixos/scripts/apply-sys.sh";
    description = "Apply the system configuration.";
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" ];
    wants = [ "network-online.target" "systemd-networkd-wait-online.service" ];
  };
}
