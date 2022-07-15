{
  config,
  pkgs,
  lib,
  ...
}:

{
  services.transmission = {
    enable = true;
    settings = {
      rpc-whitelist = "127.0.0.1";
      rpc-host-whitelist = "transmission.freeself.one";
      rpc-host-whitelist-enabled = true;
      download-dir = "/data/torrent/complete";
      incomplete-dir = "/data/torrent/incomplete";
      incomplete-dir-enabled = true;
    };
    home = "/persist/transmission";
  };
}
