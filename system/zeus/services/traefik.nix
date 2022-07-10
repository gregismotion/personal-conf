{ config,
  ...
}:

{
  config.services.traefik = {
    dataDir = "/persist/traefik/";
    staticConfigOptions = {
      entrypoints.web.address = ":80";
      entrypoints.websecure.address = ":443";

      certificatesresolvers.le.acme.email = "varigergo05@gmail.com";
      certificatesresolvers.le.acme.dnschallenge.provider = "njalla";
      certificatesresolvers.le.acme.dnschallenge.resolvers = "1.1.1.1:53,8.8.8.8:53";
      certificatesresolvers.le.acme.storage = "acme.json";

      api.dashboard = true;

      #traefik.http.routers.traefik.tls = "true";
      traefik.http.routers.traefik.tls.certresolver = "le";                                                     traefik.http.routers.traefik.tls.domains = [ {
        main = "freeself.one"; 
        sans = "*.freeself.one";
      } ];
      traefik.http.routers.traefik.service = "api@internal";

      traefik.http.middlewares.redirect-to-https.redirectscheme.scheme = "https";
      traefik.http.routers.redirs.rule = "hostregexp(`{host:.+}`)";
      traefik.http.routers.redirs.entrypoints = "web";
      traefik.http.routers.redirs.middlewares = "redirect-to-https";
      traefik.http.routers.traefik.rule = "Host(`traefik.freeself.one`)";
    };
  }; 
}
