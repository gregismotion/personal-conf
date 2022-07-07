{ config, pkgs, lib, ... }:

{
  boot = {
    # FIXME: this can change in setup.sh
    # NOTE: how big is /var? Could I assign a tmpfs to it too?...
    initrd.postDeviceCommands = lib.mkAfter ''
      zfs rollback -r sys/local/var@blank
    '';
    loader = {
      efi.canTouchEfiVariables = true;
      timeout = 3;
      grub = {
        enable = true;
        version = 2;
        efiSupport = true;
        device = "nodev";
      };
    };
  };
}
