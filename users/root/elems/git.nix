{ pkgs, ...  }:

{
  programs.git = {
    enable = true;
    userName = "root";
    userEmail = "root@freeself.one";
    extraConfig = {
      url."freeself_git:".insteadOf = "https://git.freeself.one/";
      #url."github:".insteadOf = "https://github.com/";
    };
  };
}
