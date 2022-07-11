{ config, ... }:

{
  imports = [ "${inputs.secrets}/services/zitadel/masterkey.nix" ];
  config.services.zitadel = {
    enable = true;
    extraConfig = ''
      ExternalSecure: true
      ExternalDomain: sso.freeself.one
      S3DefaultInstance:
        CustomDomain: sso.freeself.one
    '';
    extraConfigFile = config.age.secrets.services-zitadel-masterkey.path;
    extraCommand = "--tlsMode external";
  };
  config.services.cockroachdb22 = {
    enable = true;
    workingDirectory = /data/postgres/cockroach;
  };
}
