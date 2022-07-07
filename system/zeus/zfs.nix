{ config, pkgs, ...  }:
{
  networking.hostId = "fc3d22fc"; # NOTE: echo "<hostname>" | md5sum | head -c 8

  services.zfs = {
    trim.enable = true;
    autoScrub.enable = true;
    autoScrub.pools = [ "sys" "data" ]; # FIXME: this can change in setup.sh
    autoSnapshot = {
      enable = true;
      monthly = 2;
    };
  };
  
  # FIXME: this can change in setup.sh
  # NOTE: how big is /var? Could I assign a tmpfs to it too?...
  boot.initrd.postDeviceCommands = lib.mkAfter ''
    zfs rollback -r sys/local/var@blank
  '';

}
