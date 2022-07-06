{ config, lib, pkgs, ... }:

{
  boot.loader.timeout = lib.mkForce 0;
}
