{ config, pkgs, inputs, ... }:

{
  imports = [ "${inputs.secrets}/wireless/phome/phome.nix" ];
  networking = {
    useDHCP = false; # NOTE: sometime this will become default...
    wireless = {
      environmentFile = config.age.secrets.wireless-phome.path;
      enable = true;
      networks = {
        "phome_nomap".psk = "@PHOME@";
      };
    };
  };
}
