{ config, inputs, ... }:

{
  imports = [ "${inputs.secrets}/services/zitadel/zitadel.nix" ];
  config.services.zitadel = {
    enable = true;
    extraConfig = ''
      ExternalSecure: true
      ExternalDomain: sso.freeself.one
      ExternalPort: 443
      S3DefaultInstance:
        CustomDomain: sso.freeself.one
        Org:
          Human:
            Username: 'admin'
            Password: 'test'
    '';
    extraCommand = "--tlsMode external --masterkeyFile ${config.age.secrets.services-zitadel-masterkey.path}";
  };
  config.services.cockroachdb22 = {
    enable = true;
    workingDirectory = /data/postgres/cockroach;
  };
}
