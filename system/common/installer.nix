{ config, inputs, pkgs, ...  }:

{
  # FIXME: hardcoded path
  programs.bash.shellInit = ''
    WAIT=5
    echo "Starting default installation in $WAIT seconds..."
    sleep $WAIT
    until ! [ -f "/etc/nixos/scripts/install.sh" ]
    do
      sleep 2
      echo "Waiting for install script..."
    done
    /etc/nixos/scripts/install.sh
  '';
}
