{ config, pkgs, ... }:

{
  boot = {
    # FIXME: this can change in setup.sh
    # NOTE: how big is /var? Could I assign a tmpfs to it too?...
    initrd.postDeviceCommands = lib.mkAfter ''
      zfs rollback -r sys/local/var@blank
    '';
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        version = 2;
        efiSupport = true;
        device = "nodev";
      };
    };
  };
}
