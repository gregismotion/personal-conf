{ config, pkgs, ... }:

{
  age.secrets.wireless-phome.file = ../../secrets/wireless/phome.age;
  networking = {
    useDHCP = false;
    wireless = {
      environmentFile = config.age.secrets.wireless-phome.path;
      enable = true;
      networks = {
        "phome_nomap".psk = "@PHOME@";
      };
    };
  };
}
