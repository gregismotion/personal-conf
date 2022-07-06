{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  networking.hostId = "fc3d22fc"; # NOTE: echo "<hostname>" | md5sum | head -c 8

  boot.supportedFilesystems = [ "zfs" ];
  boot.zfs.devNodes = "/dev/";
  
  # TODO: override swap, fileSystems

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
