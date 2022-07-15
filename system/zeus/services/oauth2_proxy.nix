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
    redirectURL = "https://sso.freeself.one/oauth2/callback";
    upstream = [
      "https://transmission.freeself.one"
    ];
    clientID = "170138090634019182@oauth2_proxy";
    clientSecret = "gsCsMF80yiP6cK1iWnBcZevguArodMDIDihLX5NxbWMCRdUpymzvge3mAwnUKazD"; # FIXME: temp secret
    cookieSecret = "YxrNGItXaEGulQt97qEvurRAzO1MI9OUt_XrZX6UOPw="; # FIXME: temp secret
    email.domains = [ "*" ];
    extraConfig = {
      user_id_claim = "sub";
      provider_display_name = "ZITADEL";
      oidc_issuer_url = "https://issuer.zitadel.ch";
      skip_provider_button = true;
    };
  };
}
