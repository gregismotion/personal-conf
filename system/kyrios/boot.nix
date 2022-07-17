{ config, pkgs, ... }:

{
  boot = {
    resumeDevice = "/dev/disk/by-uuid/75666cdc-e2e4-498c-af76-9c6ac2a65256";
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
