{ pkgs, ...  }:

{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      github = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/id_raspi_git";
      };
      freeself = {
        hostname = "freeself.one";
        user = "pi";
        identityFile = "~/.ssh/id_rsa_raspi";
      };
      zeus = {
        hostname = "192.168.1.110";
        user = "thegergo02";
        identityFile = "~/.ssh/id_rsa_zeus";
      };
      freeself_git = {
        hostname = "git.freeself.one";
        user = "git";
        identityFile = "~/.ssh/id_rsa_zeus";
      };
    };
  };
}
