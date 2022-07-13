{
  config,
  pkgs,
  lib,
  ...
}:

{
  services.jellyfin.enable = true;
  systemd.services.jellyfin.serviceConfig = {
    StateDirectory = "/data/persist/jellyfin/state";
    CacheDirectory = "/data/persist/jellyfin/cache";
  };
}
