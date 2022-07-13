{
  config,
  ...
}:

{
  services.xserver = {
    enable = true;
    displayManager.lightdm.enable = true;
    desktopManager.kodi.enable = true;
  };

  hardware.pulseaudio.enable = true;
}
