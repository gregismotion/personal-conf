{ config, pkgs, ... }: 
{
  imports = [ ./zfs.nix ];
  fileSystems."/".options = [ "defaults"  "size=3G" "mode=755" ];
}
