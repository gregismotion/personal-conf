{ pkgs, ...  }:

{
  programs.ssh = {
    enable = true;
    matchBlocks = [
      {
        host = "github";
        hostname = "github.com";
        username = "git";
        identityFile = "~/.ssh/id_raspi_git";
      }
      {
        host = "freeself";
        hostname = "freeself.one";
        user = "pi";
        identityFile = "~/.ssh/id_rsa_raspi";
      }
      {
        host = "zeus";
        hostname = "192.168.1.110";
        user = "thegergo02";
        identityFile = "~/.ssh/id_rsa_zeus";
      }
      {
        host = "freeself_git";
        hostname = "git.freeself.one";
        user = "git";
        identityFile = "~/.ssh/id_raspi_git";
      }
    ];
  };
}
