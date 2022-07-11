{ config, ... }:

{
  config.services.zitadel = {
    enable = true;
    masterKey = "p1Au595d5UKy6nPC802FFfpn8Kgc6wuV"; # FIXME: make this secret
    extraConfig = ''
      ExternalSecure: true
      TLS:
        Enabled: false
      ExternalDomain: sso.freeself.one
      S3DefaultInstance:
        CustomDomain: sso.freeself.one
    '';
  };
  config.services.cockroachdb22 = {
    enable = true;
    workingDirectory = /data/postgres/cockroach;
  };
}
