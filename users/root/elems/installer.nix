{ pkgs, ...  }:

{
  programs.zsh.initExtra = ''
      WAIT=5
      echo "$WAIT seconds and starting default installation..."
      sleep $WAIT
      /etc/nixos/scripts/install.sh
    '';
}
