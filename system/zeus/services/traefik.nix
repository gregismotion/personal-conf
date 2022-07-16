{ 
  config,
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
        #log.level = "DEBUG";

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
         middlewares = {
            auth-headers = {
              sslRedirect = true;
              stsSeconds = 315360000;
              headers = {
                browserXssFilter = true;
                contentTypeNosniff = true;
              };
              forceSTSHeader = true;
              sslHost = "freeself.one";
              stsIncludeSubdomains = true;
              stsPreload = true;
              frameDeny = true;
            };
            forwardAuth = {
              address = "https://oauthproxy.freeself.one/oauth2/auth";
              trustForwardHeader = true;
            };
            oauth-errors = {
              errors = {
                status = [ "401-403" ];
                service = "oauth-backend";
                query = "/oauth2/sign_in";
              };
            };
          };
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
              entrypoints = [ "websecure" "web" ];
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
            jellyfin = {
              rule = "Host(`jellyfin.freeself.one`)";
              tls = {
                certresolver = "njalla";
                domains = [ {
                  main = "freeself.one"; 
                  sans = [ "*.freeself.one" ];
                } ];
              };
              entrypoints = [ "websecure" "web" ];
              service = "jellyfin";
            };
            wordpress = {
              rule = "Host(`blog.freeself.one`)";
              tls = {
                certresolver = "njalla";
                domains = [ {
                  main = "freeself.one"; 
                  sans = [ "*.freeself.one" ];
                } ];
              };
              entrypoints = [ "websecure" "web" ];
              service = "wordpress";
            };
            oauth-proxy = {
              rule = "Host(`oauthproxy.freeself.one`, `transmission.freeself.one`) && PathPrefix(`/oauth2/`)";
              tls = {
                certresolver = "njalla";
                domains = [ {
                  main = "freeself.one"; 
                  sans = [ "*.freeself.one" ];
                } ];
              };
              entrypoints = [ "websecure" "web" ];
              service = "oauth-proxy";
              middlewares = [ "auth-headers" ];
            };
            transmission = {
              rule = "Host(`transmission.freeself.one`)";
              tls = {
                certresolver = "njalla";
                domains = [ {
                  main = "freeself.one"; 
                  sans = [ "*.freeself.one" ];
                } ];
              };
              entrypoints = [ "websecure" "web" ];
              service = "transmission";
              middlewares = [ "oauth-errors" "oauth-auth" ];
            };
          };
          services = {
            sso.loadBalancer = {
              servers = [{ url = "h2c://localhost:8080"; }]; # TODO: use url specified in config
              passHostHeader = true;
            };
            git.loadBalancer = {
              servers = [{ url = "http://localhost:${toString config.services.gitea.httpPort}"; }];
              passHostHeader = true;
            };
            jellyfin.loadBalancer = {
              servers = [{ url = "http://localhost:8096"; }];
              passHostHeader = true;
            };
            wordpress.loadBalancer = {
              servers = [{ url = "http://localhost:8500"; }];
              passHostHeader = true;
            };
            oauth-proxy.loadBalancer = {
              servers = [{ url = "http://localhost:4180"; }];
              passHostHeader = true;
            };
            transmission.loadBalancer = {
              servers = [{ url = "http://localhost:9091"; }];
              passHostHeader = true;
            };
          };
        };
      };
    }; 
  };
}
