{ config, pkgs, ...  }:

{
  imports = [ groups/conf.nix ];
  systemd.services.manage-conf = {
    script = ''
      pushd /etc/

      printf "Waiting for Internet connectivity\n"
      RESPONSE=0
      while [ "$RESPONSE" != "2" ] && [ "$RESPONSE" != "3" ]
      do
	      RESPONSE=$(curl -s --max-time 2 -I https://git.freeself.one | sed 's/^[^ ]*  *\([0-9]\).*/\1/; 1q')
	      case $RESPONSE in
		      [23]) printf "\nConnectivity is up\n";;
		      5) printf "\nAccess denied or server error\n";;
		      *) printf "\nThe network is down or very slow\n";;
	      esac
      done

      nix flake clone git+ssh://freeself_git/thegergo02/personal-conf --dest nixos

      # TODO: apply somewhere (but installer does not need it for example)

      # FIXME: only workaround, shouldn't be needed
      pushd /etc/nixos
        nix flake clone git+ssh://freeself_git/thegergo02/personal-keys --dest keys
      popd
      popd
    '';
    description = "Manage the system configuration.";
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" ];
    wants = [ "network-online.target" "systemd-networkd-wait-online.service" ];
    serviceConfig.Type = "oneshot";
    path = [ pkgs.nix pkgs.curl ];
  };
}
