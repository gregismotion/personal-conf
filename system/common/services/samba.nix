{ config, pkgs, ... }:

{
  networking.firewall = {
    allowPing = true;
    allowedTCPPorts = [ 5357 445 139 ];
    allowedUDPPorts = [ 3702 137 138 ];
  };
  /*systemd.services.add-samba-users = {
    wantedBy = [ "multi-user.target" ];
    serviceConfig.Type = "oneshot";
    description = "Add SMB users.";
    path = [ pkgs.samba  ];
    script = ''
      smbpasswd -a varitomi12
      smbpasswd -a thegergo02
    '';
  };*/
  services = {
    samba-wsdd.enable = true; # NOTE: win10 compatability
    samba = {
      enable = true;
      openFirewall = true;
      securityType = "user";
      # NOTE: netbios name can only be 15 chars, be careful
      extraConfig = ''
        workgroup = personal-conf
        server role = standalone server
        server string = ${config.networking.hostName}-samba
        netbios name = ${config.networking.hostName}
        max protocol = smb3
        hosts allow = 192.168.0. 127.0.0.1 localhost
        hosts deny = 0.0.0.0/0
        map to guest = bad user
      '';
      shares = {
        share = {
          path = "/data/share";
          browseable = "yes";
          "read only" = "no";
          "guest ok" = "yes";
          "create mask" = "0644";
          "directory mask" = "0755";
        };
        important = {
          path = "/data/important";
          browseable = "yes";
          "read only" = "no";
          "guest ok" = "no";
          "create mask" = "0644";
          "directory mask" = "0755";
        };
        homes = {
          browseable = "no";
          "read only" = "no";
          "guest ok" = "no";
        };
      };
    };
  };
}
