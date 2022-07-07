{ config, pkgs, inputs, lib, ... }:

{
  users = {
    users.root = {
      password = "nixos";
    };
  };
  services.getty.autologinUser = lib.mkForce "root";
}
