{ 
  config, 
  inputs,
  pkgs,
  ... 
}:

{
  imports = [ "${inputs.secrets}/services/zitadel/zitadel.nix" ];
  config = {
    services.zitadel = {
      enable = true;
      extraConfig = ''
        ExternalSecure: true
        ExternalDomain: sso.freeself.one
        ExternalPort: 443
        S3DefaultInstance:
          CustomDomain: sso.freeself.one
      '';
      extraCommand = "--tlsMode external --steps ${config.age.secrets.services-zitadel-admin.path} --masterkeyFile ${config.age.secrets.services-zitadel-masterkey.path}";
    };
    systemd.services.zitadel.serviceConfig.After = "cockroachdb22.socket";
    systemd.sockets.cockroachdb22 = {
      wantedBy = [ "sockets.target" ];
      socketConfig = {
        ListenStream = "26257";
        Accept = false;
        Service = "cockroachdb22.service";
      };
    };
    systemd.services.zitadel.unitConfig.Requires = [ "cockroachdb22.socket" ];
    services.cockroachdb22 = {
      enable = true;
      workingDirectory = /data/postgres/cockroach;
    };
  };
}
