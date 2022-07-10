{ config, ... }:

{
  config.services.zitadel = {
    enable = true;
    masterKey = "p1Au595d5UKy6nPC802FFfpn8Kgc6wuV";
    extraConfig = ''
      ExternalSecure: false
      TLS:
        Enabled: false
      ExternalDomain: zitadel.freeself.one
      S3DefaultInstance:
        CustomDomain: zitadel.freeself.one
    '';
  };
  config.services.cockroachdb22 = {
    enable = true;
    workingDirectory = /data/postgres/cockroach;
  };
}
