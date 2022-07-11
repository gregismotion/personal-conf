{ config,
  pkgs,
  ...
}:

{
  config = {
    networking.firewall.allowedTCPPorts = [ 80 443 ];
    systemd.services.traefik.serviceConfig.EnvironmentFile = pkgs.writeText ".env" ''
      NJALLA_TOKEN=0d4135046a33a5737ef560ede0c6d6ac2170fa6c
    '';
    services.traefik = {
      enable = true;
      dataDir = "/persist/traefik/";
      staticConfigOptions = {
        log.level = "DEBUG";
        entrypoints = {
          web.address = ":80";
          websecure.address = ":443";
        };

        certificatesresolvers.njalla.acme = {
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
                certresolver = "njalla";
                domains = [ {
                  main = "freeself.one"; 
                  sans = [ "*.freeself.one" ];
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
