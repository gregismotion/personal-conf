{
  config,
  pkgs,
  lib,
  ...
}:

{
  services.transmission.settings = {
    enable = true;
    rpc-whitelist = "127.0.0.1";

    download-dir = "/data/torrent/complete";

    incomplete-dir = "/data/torrent/incomplete";
    incomplete-dir-enabled = true;

    home = "/persist/transmission";
  };
}
