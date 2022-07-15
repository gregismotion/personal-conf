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
      enable = false;
      extraConfig = ''
        ExternalSecure: true
        ExternalDomain: sso.freeself.one
        ExternalPort: 443
        S3DefaultInstance:
          CustomDomain: sso.freeself.one
      '';
      extraCommand = "--tlsMode external --steps ${config.age.secrets.services-zitadel-admin.path} --masterkeyFile ${config.age.secrets.services-zitadel-masterkey.path}";
    };
    
    systemd.services.zitadelAndCockroach = {
      enable = true;
      script = config.services.cockroachdb22.startScript + config.services.zitadel.startScript;
    };

    services.cockroachdb22 = {
      enable = false;
      workingDirectory = /data/postgres/cockroach;
    };

  };
}
