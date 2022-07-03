{ config, inputs, pkgs, ...  }:

{
  services.openssh.knownHosts = {
    freeself = {
      hostNames = [ "git.freeself.one" ];
      publicKey = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDWjTYoMi6P3OG4x4S1eLeC1pl7Y/KMh5akdjLNQq3lZamuci4KgE84dgeuqS2NxNBNr2sQcvdwUBB+FLUKL04ZM5h3NWcPWHFcbJ/9bHPBVHR3tp2h15014j9nSm4Pv6gPzFz4ddKJDnTu/7kqn1S811DNUU1hhY06XYteMZVAHWB1UmCXz2SNf0z9r2BBLIoe+GHXw40czO63UpAw/OCnS0LK7h1L2EPJfoFfnzfznMmHcMN7E/59ddYiwuSEzjGnvl1GZcPjyWwVB+nx7IrwziEdRlU4zmZY99cyhwxomuMzBzzfr5hV5+AH06LFpNSuwI0D7XGDHM0AFSd6vyIac0V23AP7j4yqVCoT2VAv+vy3N6u7DWSnWrmBQrnrksZ2hBGpwPOX/trPW/CpVEZUTVz9HkuRXPib4g5cv9EiwQoTulGgnenqLTGwShb4j1zQdRzcuCLkWyxmjW2sf5p4T/viQ6rc2Ue1TccOUXcYsu+RHkQmBST/qFHPXlHCyAM=";
    };
  };

  age.identityPaths = [ "/etc/nixos/keys/${config.networking.hostName}/id_rsa" ];
  
  environment.etc."ssh/id_rsa" = {
    mode = "0600";
    source = 
    "${inputs.keys}/${config.networking.hostName}/id_rsa";
  };
  environment.etc."ssh/id_rsa.pub" = {
    mode = "0600";
    source = 
    "${inputs.keys}/${config.networking.hostName}/id_rsa.pub";
  };
}
