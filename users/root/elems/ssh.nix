{ pkgs, config, options, ...  }:

{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      freeself_git = {
        hostname = "git.freeself.one";
        user = "git";
        identityFile = "/persist/nixos/keys/$HOST/id_rsa";
      };
    };
  };
}
