{ pkgs, ...  }:

{
  programs.git = {
    enable = true;
    userName = "thegergo02";
    userEmail = "work@varigergo.xyz";
    extraConfig = {
      init.defaultBranch = "master";
      url."github:".insteadOf = "https://github.com/";
      url."freeself_git:".insteadOf = "https://git.freeself.one/";
      safe.directory = "*";
    };
  };
}
