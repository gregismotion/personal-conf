{ config, ... }:

{
  config.services.zitadel = {
    enable = true;
    masterKey = "p1Au595d5UKy6nPC802FFfpn8Kgc6wuV";
    extraConfig = ''
      ExternalSecure: false
      TLS:
        Enabled: false
      ExternalDomain: 192.168.1.110
      S3DefaultInstance:
        CustomDomain: 192.168.1.110
    '';
  };
  config.services.cockroachdb22 = {
    enable = true;
    workingDirectory = /data/postgres/cockroach;
  };
}
