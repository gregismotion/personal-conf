{ config, pkgs, ...  }:
{
  networking.hostId = "fc3d22fc"; # NOTE: echo "<hostname>" | md5sum | head -c 8

  services.zfs = {
    trim.enable = true;
    autoScrub.enable = true;
    autoScrub.pools = [ "sys" ]; # FIXME: this can change in setup.sh
    autoSnapshot = {
      enable = true;
      monthly = 2;
    };
  };
}
