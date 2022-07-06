{ config, pkgs, ...  }:
{
  networking.hostId = "fc3d22fc"; # NOTE: echo "<hostname>" | md5sum | head -c 8

  /*boot = {
    initrd.supportedFilesystems = [ "zfs" ];
    supportedFilesystems = [ "zfs" ];
  };*/
  
  fileSystems = {
    "/data/torrent".options = [ "noauto" ];
    "/data/share".options = [ "noauto" ];
    "/data/postgres".options = [ "noauto" ];
    "/data/important".options = [ "noauto" ];
  };

  services.zfs = {
    trim.enable = true;
    autoScrub.enable = true;
    autoScrub.pools = [ "sys" "data" ]; # FIXME: this can change in setup.sh
    autoSnapshot = {
      enable = true;
      monthly = 2;
    };
  };
}
