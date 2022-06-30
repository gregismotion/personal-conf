{ pkgs, ... }: {
  home.username = "thegergo02";
  home.homeDirectory = "/home/thegergo02";
  
  programs.home-manager.enable = true;    

  gtk = {
    enable = true;
    theme = {
      name = "amarena";
      package = pkgs.amarena-theme;
    };
  };
  qt = {
    enable = true;
    platformTheme = "gtk";
    style = {
      name = "gtk2";
      package = pkgs.qtstyleplugins;
    };
  };
  
  home.file.".config/bspwm".source = ../../config/bspwm;
  home.file.".config/sxhkd".source = ../../config/sxhkd;

  services.sxhkd.enable = true;
  xsession = {
    enable = true;
    windowManager.bspwm.enable = true;
  };

  home.packages = with pkgs; [ 
    libreoffice joplin-desktop
    mosh
    vscodium pkgs.godot
    redshift
    keepassxc
    rofi maim
    dconf
  ];

  programs.git = {
    enable = true;
    userName = "thegergo02";
    userEmail = "work@varigergo.xyz";
    extraConfig = {
      init.defaultBranch = "master";
      url."github:".insteadOf = "https://github.com/";
      url."freeself_git:".insteadOf = "https://git.freeself.one/";
    };
  };

  programs.zsh = {
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
  
  home.sessionVariables.EDITOR = "${pkgs.vim}/bin/vim";
  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [ vim-airline ];
  };

  systemd.user.startServices = true;
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
  };
  services.redshift = {
    enable = true;
    dawnTime = "05:00";
    duskTime = "17:00";
    temperature = {
            day = 5500;
            night = 3700;
    };
  };
  services.syncthing = {
    enable = true;
  };
}
