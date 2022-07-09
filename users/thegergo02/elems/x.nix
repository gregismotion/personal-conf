{ pkgs, ...  }: {
  home.packages = with pkgs; [ 
    libreoffice joplin-desktop
    vscodium pkgs.godot
    redshift
    keepassxc
    rofi maim
    dconf
  ];
  
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
  
  home.file.".config/bspwm".source = ../../../config/bspwm;
  home.file.".config/sxhkd".source = ../../../config/sxhkd;

  services.sxhkd.enable = true;
  xsession = {
    enable = true;
    windowManager.bspwm.enable = true;
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
}
