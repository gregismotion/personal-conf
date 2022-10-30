# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "ohci_pci" "ehci_pci" "pata_atiixp" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "root";
      fsType = "tmpfs";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/611C-0B0E";
      fsType = "vfat";
    };

  fileSystems."/var" =
    { device = "sys/local/var";
      fsType = "zfs";
    };

  fileSystems."/nix" =
    { device = "sys/safe/nix";
      fsType = "zfs";
    };

  fileSystems."/home" =
    { device = "sys/safe/home";
      fsType = "zfs";
    };

  fileSystems."/root" =
    { device = "sys/safe/home/root";
      fsType = "zfs";
    };

  fileSystems."/persist" =
    { device = "sys/safe/persist";
      fsType = "zfs";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/b52c3ef6-1bec-41d7-a6cc-d4baa3e2abb7"; }
    ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp1s0.useDHCP = lib.mkDefault true;

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
