{ config, pkgs, ...  }:

{
  services.xserver = {
	enable = true;
	layout = "us,hu";
        xkbOptions = "eurosign:e,grp:win_space_toggle";
        desktopManager.xterm.enable = true; # NOTE: workaround
  };

  environment.systemPackages = with pkgs; [
    alacritty
    ungoogled-chromium
  ];

  sound.enable = true;
  hardware.pulseaudio.enable = true;
}
