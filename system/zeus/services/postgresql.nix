{
  config,
  ...
}:

{
  services.postgresql = {
    enabled = true;
    dataDir = /data/postgres/11;
    authentication = ''
      local gitea all ident map=gitea-users
    '';
    identMap = ''
      gitea-users gitea gitea
    '';
  };
}
