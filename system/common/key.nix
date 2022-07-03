{ config, inputs, ...  }:

{
  environment.etc."ssh/ssh_known_hosts".source = 
    "${inputs.keys}/${config.networking.hostName}/ssh_known_hosts";

  environment.etc."ssh/id_rsa_secret".source = 
    "${inputs.keys}/${config.networking.hostName}/id_rsa_secret";
  environment.etc."ssh/id_rsa_secret.pub".source = 
    "${inputs.keys}/${config.networking.hostName}/id_rsa_secret.pub";

  environment.etc."ssh/id_rsa".target = "id_rsa_secret";
}
