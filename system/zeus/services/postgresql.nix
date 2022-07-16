{
  config,
  ...
}:

{
  services.postgresql = {
    enable = true;
    dataDir = "/data/postgres/11";
    authentication = ''
      local gitea all ident map=gitea-users
      local wordpress all ident map=wordpress-users
    '';
    identMap = ''
      gitea-users gitea gitea
      wordpress-users wordpress wordpress
    '';
  };
}
