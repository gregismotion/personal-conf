{ config, pkgs, ...  }:

{
  services.xserver = {
	enable = true;
	layout = "us,hu";
	xkbOptions = "eurosign:e,grp:win_space_toggle";
	windowManager.bspwm = { 
		enable = true;
		configFile = "/home/thegergo02/.config/bspwm/bspwmrc";
		sxhkd.configFile = "/home/thegergo02/.config/sxhkd/sxhkdrc";
	};
  };

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;
}
