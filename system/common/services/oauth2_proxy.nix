{
  config,
  pkgs,
  lib,
  ...
}:

{
  services.oauth2_proxy = {
    enable = true;
    provider = "oidc";
    redirectUrl = "https://sso.freeself.one/oauth2/callback";
    upstream = [
      "https://transmission.freeself.one"
    ];
    email.domains = [ "*" ];
    extraConfig = {
      user_id_claim = "sub";
      provider_display_name = "ZITADEL";
      oidc_issuer_url = "https://issuer.zitadel.ch";
      skip_provider_button = true;
    };
  };
}
