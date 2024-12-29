{ config, pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    #nvim    # enable if don't want to be managed by home-manager
  ];


  programs.neovim = {
    enable = true;      # disable if not want to be managed by home-manager
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

      extraLuaConfig = ''
      ${builtins.readFile ./nvim/options.lua}
    '';
  };

 # home.file.".config/nvim".source = ./.;
 # home.file.".config/nvim".recursive = true;
 # home.file.".config/nvim/lua/themes/stylix.lua".source = config.lib.stylix.colors {
 #     template = builtins.readFile ./lua/themes/stylix.lua.mustache;
 #     extension = ".lua";
 # };
}

