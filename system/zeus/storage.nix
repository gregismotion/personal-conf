{ config, pkgs, ... }: 
{
  imports = [ ./zfs.nix ];
  fileSystems."/".options = [ "defaults"  "size=1G" "mode=755"  ];
  fileSystems."/data/share".options = [ "defaults"  "mode=755"  ];
}
