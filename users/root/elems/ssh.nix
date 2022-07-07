{ pkgs, config, options, ...  }:

{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      freeself_git = {
        hostname = "git.freeself.one";
        user = "git";
        identityFile = "/persist/keys/installer/id_rsa";
        # FIXME: couldn't properly get hostname, hotfix
	github = {
	  hostname = "https://github.com";
	};
      };
    };
  };
}
