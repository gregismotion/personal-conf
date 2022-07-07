{ config, pkgs, ... }: 
{
  imports = [ ./zfs.nix ];
  fileSystems."/".options = [ "defaults"  "size=1G" "mode=755" ];
}
