{ config, pkgs, ... }:

{
  services.  
  networking.firewall = {
    allowPing = true;
    allowedTCPPorts = [ 5357 445 139 ];
    allowedUDPPorts = [ 3702 137 138 ];
  };
  services = {
    samba-wsdd.enable = true; # NOTE: win10 compatability
    samba = {
      enable = true;
      openFirewall = true;
      securityType = "user";
      extraConfig = ''
        workgroup = WORKGROUP
        server role = standalone server
        server string = smbnix
        netbios name = smbnix
        security = user 
        #use sendfile = yes
        #max protocol = smb2
        hosts allow = 192.168.0. 127.0.0.1 localhost
        hosts deny = 0.0.0.0/0
        guest account = nobody
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
          "force user" = "username";
          "force group" = "groupname";
        };
        important = {
          path = "/data/important";
          browseable = "yes";
          "read only" = "no";
          "guest ok" = "yes";
          "create mask" = "0644";
          "directory mask" = "0755";
          "force user" = "username";
          "force group" = "groupname";
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
