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
    systemd.services.zitadel.serviceConfig.After = "cockroachdb22.service";
    systemd.services.cockroachdb22 = {
      path = [ pkgs.coreutils ];
      serviceConfig.ExecStartPost="timeout 30 sh -c 'while ! ss -H -t -l -n sport = :26257 | grep -q \"^LISTEN.*:26257\"; do sleep 1; done'";
    };
    services.cockroachdb22 = {
      enable = true;
      workingDirectory = /data/postgres/cockroach;
    };
  };
}
