{ config, pkgs, ... }:

{
  /*services.logind.extraConfig = ''
    HandlePowerKey=hibernate
    HandleSuspendKey=hibernate
  '';*/
  boot = {
    kernelModules = ["v4l2loopback"];
    extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
    extraModprobeConfig = ''
      options v4l2loopback exclusive_caps=1 card_label="Virtual Camera" width=1920 height=1080
    '';
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
    initrd = {
      kernelModules = ["v4l2loopback"];
      luks.devices = {
        main = {
          device = "/dev/disk/by-uuid/552fc524-4a40-4d72-8935-00e485adb016";
          preLVM = true;
        };
      };
    };
  };
}
