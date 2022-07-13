{ 
  config, 
  pkgs, 
  inputs,
  ... 
}:

{
  imports = [
    ../common/type/headless.nix
    ./hardware-configuration.nix
    ../common/flakes.nix
    ../common/basic.nix
    ../common/users.nix
    ../common/manage-conf.nix
    ../common/key.nix
    ../common/hardware/rpi4-gpu.nix
    ../common/services/ssh.nix
  ];
  
  system.stateVersion = "22.05";
  time.timeZone = "Europe/Budapest";
  
  networking.hostName = "aphrodite";

  imports = [ "${inputs.rpi4-config}/raspberry-pi/4" ];
}
