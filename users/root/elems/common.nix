{ pkgs, ... }: {
  home = {
    username = "root";
    homeDirectory = "/root";
  };
  programs.home-manager.enable = true;
}
