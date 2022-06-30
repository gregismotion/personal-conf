{ pkgs, ... }: {
  imports = [ ./editor.nix ];
  programs = {
    git = {
      enable = true;
      userName = "thegergo02";
      userEmail = "work@varigergo.xyz";
      extraConfig = {
        init.defaultBranch = "master";
        url."github:".insteadOf = "https://github.com/";
        url."freeself_git:".insteadOf = "https://git.freeself.one/";
        safe.directory = "/etc/nixos"; # FIXME: this could change
      };
    };

    zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      plugins = [
        {
          name = "pure";
          src = pkgs.fetchFromGitHub {
            owner = "sindresorhus";
            repo = "pure";
            rev  = "v1.20.1";
            sha256 = "1bxg5i3a0dm5ifj67ari684p89bcr1kjjh6d5gm46yxyiz9f5qla";
          };
        }
        {
          name = "zsh-nix-shell";
          file = "nix-shell.plugin.zsh";
          src = pkgs.fetchFromGitHub {
            owner = "chisui";
            repo = "zsh-nix-shell";
            rev = "v0.5.0";
            sha256 = "0za4aiwwrlawnia4f29msk822rj9bgcygw6a8a6iikiwzjjz0g91";
          };
        }
      ];
    };
  };
}
