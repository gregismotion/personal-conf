{ config, pkgs, ... }:

{
  programs = {
    adb.enable = true;
    scrcpy.enable = true;
  };
}
