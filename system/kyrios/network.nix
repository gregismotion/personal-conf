{ config, pkgs, ... }:

{
  age.secrets.wireless-phome.file = ../../secrets/wireless/phome.age;
  networking = {
    useDHCP = false;
    interfaces.wlp0s16f1u1.useDHCP = true;
    wireless = {
      environmentFile = config.age.secrets.wireless-phome.path;
      enable = true;
      networks = {
        "phome_nomap".psk = "@PHOME@";
      };
    };
  };
}
