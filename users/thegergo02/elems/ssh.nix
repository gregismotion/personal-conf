{ pkgs, ...  }:

{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      github = {
        hostname = "github.com";
        user = "git";
        identityFile = "id_rsa_thegergo02t";
      };
      zeus_local = {
        hostname = "192.168.1.110";
        user = "thegergo02";
        identityFile = "id_rsa_thegergo02";
      };
      freeself_git = {
        hostname = "git.freeself.one";
        user = "gitea";
        identityFile = "id_rsa_thegergo02";
      };
    };
  };
}
