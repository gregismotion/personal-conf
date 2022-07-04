{ pkgs, ... }: {
  imports = [ ./elems/common.nix ./elems/shell.nix ./elems/git.nix ./elems/ssh.nix ];
}
