{ config, pkgs, ...  }:

{
  services.xserver = {
	enable = true;
	layout = "us,hu";
        xkbOptions = "eurosign:e,grp:win_space_toggle";
        desktopManager.xterm.enable = true; # NOTE: workaround
  };

  environment.systemPackages = with pkgs; [
    rofi maim 
    alacritty
    keepassxc
  ];

  sound.enable = true;
  hardware.pulseaudio.enable = true;
}
