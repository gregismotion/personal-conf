{ pkgs, ... }: {
  imports = [ ./elems/common.nix ./elems/shell.nix ./elems/installer.nix ];
}
