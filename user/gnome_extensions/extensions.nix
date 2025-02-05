{config, pkgs, ... }:
{
  home.packages = with pkgs.gnomeExtensions; [
    # Command Line
    blur-my-shell
    appindicator
    pop-shell  
  ];
}
