{ config,
  ...
}:

{
  config.services.traefik = {
    dataDir = "/persist/traefik/";
    staticConfigOptions = {
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
        storage = "acme.json";
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
}
