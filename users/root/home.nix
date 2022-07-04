{ pkgs, ... }: {
  imports = [ ./ssh.nix ./git.nix ];
}
