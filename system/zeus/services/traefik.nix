{ config,
  pkgs,
  ...
}:

{
  config = {
    networking.firewall.allowedTCPPorts = [ 80 443 ];
    systemd.services.traefik.serviceConfig.EnvironmentFile = pkgs.writeText ".env" ''
      NJALLA_TOKEN=4082e5d2f5e60aa08a503757b0002492e0e6022c
    '';
    services.traefik = {
      enable = true;
      dataDir = "/persist/traefik/";
      staticConfigOptions = {
        log.level = "DEBUG";

        api.dashboard = true;

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
      };
      dynamicConfigOptions = {
        http = {
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
              service = "zitadel";
              loadbalancer.server.port = 8080;
            };
          };
          middlewares.redirect-to-https.redirectscheme.scheme = "https";
        };
      };
    }; 
  };
}
