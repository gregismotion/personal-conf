{ config, pkgs, ...  }:

{
  imports = [ groups/conf.nix ];
  systemd.services.manage-conf = {
    script = ''
      cd /etc/

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

      if [[ ! -d "/etc/nixos/.git" ]]; then
        rm -rf nixos
        git clone https://git.freeself.one/thegergo02/personal-conf
        mv personal-conf nixos
      fi

      # TODO: apply somewhere (but installer does not need it for example)
    '';
    description = "Manage the system configuration.";
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" ];
    wants = [ "network-online.target" "systemd-networkd-wait-online.service" ];
    serviceConfig.Type = "oneshot";
    path = [ pkgs.git pkgs.curl ];
  };
}
