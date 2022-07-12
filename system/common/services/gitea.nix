{
  config,
  pkgs,
  lib,
  ...
}:

{
  services.gitea = {
    enable = true;
    appName = "Gitea: FREESELF";
    database = {
      type = "postgres";
    };
    domain = "git.freeself.one";
    rootUrl = "https://${services.gitea.domain}";
    httpPort = 3000;
    extraConfig = let
      docutils =
	pkgs.python37.withPackages (ps: with ps; [
	  docutils
	  pygments
      ]);
    in ''
      [markup.restructuredtext]
      ENABLED = true
      FILE_EXTENSIONS = .rst
      RENDER_COMMAND = ${docutils}/bin/rst2html.py
      IS_INPUT_FILE = false
    '';    
  };
}
