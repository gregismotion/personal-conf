{ config, inputs, pkgs, ...  }:

{
  programs.bash.shellInit = ''
    WAIT=5
    echo "Starting default install in $WAIT seconds..."
    sleep $WAIT
    /etc/nixos/scripts/install.sh
  '';
}
