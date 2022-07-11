{ config, inputs, ... }:

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
    #extraConfigFile = config.age.secrets.services-zitadel-masterkey.path;
    # FIXME: finish secrets
    extraCommand = "--tlsMode external --masterkey 4Nilm7RZJ9rOu0oBcnFm1cTtWKIpj9Jz";
  };
  config.services.cockroachdb22 = {
    enable = true;
    workingDirectory = /data/postgres/cockroach;
  };
}
