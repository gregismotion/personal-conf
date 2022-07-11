{ config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [ "${inputs.secrets}/services/njalla/njalla.nix" ];
  config = {
    networking.firewall.allowedTCPPorts = [ 80 443 ];
    systemd.services.traefik.serviceConfig.EnvironmentFile = pkgs.writeText ".env" ''
      NJALLA_TOKEN_FILE=${config.age.secrets.services-njalla-token.path}
      NJALLA_TTL=1
      NJALLA_POLLING_INTERVAL=5
      NJALLA_PROPAGATION_TIMEOUT=1200
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
            resolvers = [ "1.1.1.1:53" "8.8.8.8:53" ];
          };
          #caServer = "https://acme-staging-v02.api.letsencrypt.org/directory";
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
              entrypoints = [ "web" ];
              middlewares = "redirect-to-https";
            };
            sso = {
              rule = "Host(`sso.freeself.one`)";
              tls = {
                certresolver = "njalla";
                domains = [ {
                  main = "freeself.one"; 
                  sans = [ "*.freeself.one" ];
                } ];
              };
              entrypoints = [ "websecure" "web" ];
              service = "sso";
            };
          };
          services = {
            sso.loadBalancer = {
              servers = [{ url = "http://localhost:8080"; }];
              passHostHeader = true;
            };
          };
          middlewares.redirect-to-https.redirectscheme.scheme = "https";
        };
      };
    }; 
  };
}
