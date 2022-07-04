{ pkgs, ... }: {
  imports = [ ./editor.nix ./git.nix ./zsh.nix ./ssh.nix ];
}
