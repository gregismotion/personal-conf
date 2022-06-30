{ pkgs, ...  }: {
  home.sessionVariables.EDITOR = "${pkgs.vim}/bin/vim";
  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [ vim-airline ];
  };
}
