{ pkgs, ... }: {
  imports = [ ./elems/common.nix ./elems/shell.nix ] ++ [ ./elems/x.nix ./services/syncthing.nix ];
}
