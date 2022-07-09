{ config, pkgs, ... }:

{
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        version = 2;
        efiSupport = true;
        enableCryptodisk = true;
        device = "nodev";
      };
    };
    initrd.luks.devices = {
      main = {
        device = "/dev/disk/by-uuid/552fc524-4a40-4d72-8935-00e485adb016";
        preLVM = true;
      };
    };
  };
}
