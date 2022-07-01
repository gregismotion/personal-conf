{ pkgs, config, ... }: {
  home = {
    username = "thegergo02";
    homeDirectory = "/home/thegergo02";
  };
  programs.home-manager.enable = true;

  imports = [ ./shell.nix ] ++ (if ../../system/common/is_headless.nix then [] else [ ./x.nix ./services/syncthing.nix ]);
}
