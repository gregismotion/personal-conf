{ pkgs, ... }: {
  home = {
    username = "thegergo02";
    homeDirectory = "/home/thegergo02";
  };
  programs.home-manager.enable = true;

  imports = [ ./shell.nix ] ++ (if true then [ ./x.nix ./services/syncthing.nix  ] else []);
}
