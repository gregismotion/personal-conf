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
          web = {
            address = ":80";
            http.redirections.entryPoint = {
              to = "websecure";
              scheme = "https";
            };
          };
          websecure.address = ":443";
        };

        certificatesresolvers.njalla.acme = {
          email = "varigergo05@gmail.com";
          dnschallenge = {
            provider = "njalla";
            resolvers = [ "1.1.1.1:53" "8.8.8.8:53" ];
          };
          # NOTE: when testing, uncomment to use staging servers (severe risk of being rate-limited)
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
            git = {
              rule = "Host(`git.freeself.one`)";
              tls = {
                certresolver = "njalla";
                domains = [ {
                  main = "freeself.one"; 
                  sans = [ "*.freeself.one" ];
                } ];
              };
              entrypoints = [ "websecure" "web" ];
              service = "git";
            };
          };
          services = {
            sso.loadBalancer = {
              servers = [{ url = "h2c://localhost:8080"; }]; # TODO: use url specified in config
              passHostHeader = true;
            };
            git.loadBalancer = {
              servers = [{ url = "http://localhost:${services.gitea.httpPort}"; }];
              passHostHeader = true;
            };
          };
        };
      };
    }; 
  };
}
