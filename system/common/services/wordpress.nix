{ config, pkgs, ...  }:

{
  services.wordpress.sites."varigergo.xyz" = {
    database = {
      host = "localhost";
      port = "5432";
      user = "wordpress";
    };
    virtualHost.listen."*".port = 8500;
    uploadsDir = "/data/persist/wordpress/uploads";
  };
}
