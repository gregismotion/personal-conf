{ config, pkgs, inputs, ... }:

{
  users = {
    users.root = {
      password = "nixos";
      services.getty.autologinUser = lib.mkDefault "root";
    };
  };
  programs.git = {
    enable = true;
    extraConfig = {
      url."freeself:".insteadOf = "git+ssh://git@git.freeself.one:";
    };
  };
}
