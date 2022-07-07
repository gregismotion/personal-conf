{ config, inputs, pkgs, ...  }:

{
  # FIXME: hardcoded path
  programs.bash.shellInit = ''
    WAIT=10
    echo "Starting default installation in $WAIT seconds..."
    sleep $WAIT
    /persist/nixos/scripts/install.sh
    reboot
  '';
}
