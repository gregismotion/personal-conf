{ config, inputs, ...  }:

{
  environment.etc."ssh/id_rsa_secret".source = 
    "${inputs.keys}/${config.networking.hostName}/id_rsa_secret";
  environment.etc."ssh/id_rsa_secret.pub".source = 
    "${inputs.keys}/${config.networking.hostName}/id_rsa_secret.pub";
}
