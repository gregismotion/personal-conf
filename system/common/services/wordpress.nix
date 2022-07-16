{ config, pkgs, ...  }:

{
  services.wordpress."varigergoxyz".virtualHost.listen."*".port = 8500;
  services.wordpress.sites."varigergoxyz" = {
    database = {
      host = "localhost";
      port = "5432";
      user = "wordpress";
    };
    uploadsDir = "/data/persist/wordpress/uploads";
  };
}
