{ config, pkgs, ...  }:

{
  services.wordpress.sites."varigergoxyz".virtualHost = {
    listen = [
      {
        port = 8500;
      }
    ];
    adminAddr = "thegergo02@freeself.one";
  };
  services.wordpress.sites."varigergoxyz" = {
    database = {
      host = "localhost";
      port = 5432;
      user = "wordpress";
    };
    uploadsDir = "/data/persist/wordpress/uploads";
    extraConfig = ''
      define('SCRIPT_DEBUG', true);
    '';
  };
}
