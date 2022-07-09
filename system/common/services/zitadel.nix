{ config, ... }:

{
  config.services.zitadel = {
    enable = true;
    masterKey = "p1Au595d5UKy6nPC802FFfpn8Kgc6wuV";
    extraConfig = ''
      ExternalSecure: false
      TLS:
        Enabled: false
      ExternalDomain: zeus
      S3DefaultInstance:
        CustomDomain: zeus
    '';
  };
  config.services.cockroachdb22 = {
    enable = true;
    workingDirectory = /data/postgres/cockroach;
  };
}
