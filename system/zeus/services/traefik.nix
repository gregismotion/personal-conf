{ config,
  pkgs,
  ...
}:

{
  config = {
    networking.firewall.allowedTCPPorts = [ 80 443 ];
    services.traefik.serviceConfig.EnvironmentFile = pkgs.writeText ".env" ''
      NJALLA_TOKEN=0d4135046a33a5737ef560ede0c6d6ac2170fa6c
      NJALLA_TTL=1
      NJALLA_POLLING_INTERVAL=5
      NJALLA_PROPAGATION_TIMEOUT=1200
      CF_API_EMAIL=varigergo05@gmail.com
      CF_API_KEY=TD6DZifvDmpbLFJBAFrdnutSjg2qMaoy_nPng8Ax
    '';
    services.traefik = {
      enable = true;
      dataDir = "/persist/traefik/";
      staticConfigOptions = {
        log.level = "INFO";
        entrypoints = {
          web.address = ":80";
          websecure.address = ":443";
        };

        certificatesresolvers.le.acme = {
          email = "varigergo05@gmail.com";
          dnschallenge = {
            provider = "njalla";
            resolvers = "1.1.1.1:53,8.8.8.8:53";
          };
          storage = "${config.services.traefik.dataDir}/acme.json";
        };

        api.dashboard = true;

        traefik.http = {
          routers = {
            traefik = {
              rule = "Host(`traefik.freeself.one`)";
              tls = {
                certresolver = "le";
                domains = [ {
                  main = "freeself.one"; 
                  sans = "*.freeself.one";
                } ];
              };
              service = "api@internal";
            };
            redirs = {
              rule = "hostregexp(`{host:.+}`)";
              entrypoints = "web";
              middlewares = "redirect-to-https";
            };
            sso = {
              rule = "Host(`sso.freeself.one`)";
              tls = true;
              entrypoints = "websecure";
              loadbalancer.server.port = 8080;
            };
          };
          middlewares.redirect-to-https.redirectscheme.scheme = "https";
        };
      };
    }; 
  };
}
