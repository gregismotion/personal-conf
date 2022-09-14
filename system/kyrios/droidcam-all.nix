let v4l2loopback-dc = pkgs.callPackage ./v4l2loopback-dc.nix {
      kernel = pkgs.linux_4_19;
    };
    droidcam = pkgs.callPackage ./droidcam.nix {};
in {
  boot.extraModulePackages = [ v4l2loopback-dc ];
  environment.systemPackages = [ droidcam ];
}
