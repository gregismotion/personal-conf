{ config, inputs, pkgs, ...  }:

{
  age.identityPaths = [ "/etc/nixos/keys/${config.networking.hostName}/id_rsa" ];
  
  environment.etc."ssh/id_rsa" = {
    mode = "0600";
    source = 
    "${inputs.keys}/${config.networking.hostName}/id_rsa_secret";
  }
  environment.etc."ssh/id_rsa.pub" = {
    mode = "0600";
    source = 
    "${inputs.keys}/${config.networking.hostName}/id_rsa_secret.pub";
  }
}
