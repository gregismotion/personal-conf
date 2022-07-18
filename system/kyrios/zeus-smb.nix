{ config, pkgs, ... }:

{
  imports = [ "${inputs.secrets}/services/smb/smb.nix" ];
  fileSystems."/mnt/zeus" = {
    device = "//zeus";
    fsType = "cifs";
    options = let
      # this line prevents hanging on network split
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";

    in ["${automount_opts},credentials=${config.age.secrets.services-smb-thegergo02-cred.path}"];
  };
}
