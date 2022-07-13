{
  config,
  pkgs,
  lib,
  ...
}:

{
  services.jellyfin.enable = true;
  systemd.services.jellyfin.serviceConfig = {
    StateDirectory = lib.mkForce "/data/persist/jellyfin/state";
    CacheDirectory = lib.mkForce "/data/persist/jellyfin/cache";
    ExecStart = "${config.services.jellyfin.package}/bin/jellyfin --datadir '${systemd.services.jellyfin.serviceConfig.StateDirectory}' --cachedir '${systemd.services.jellyfin.serviceConfig.CacheDirectory}'";
  };
}
