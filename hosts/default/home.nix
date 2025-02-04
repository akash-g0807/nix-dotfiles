{ config, pkgs, inputs, userSettings, ... }:

{

  home.username = "akashg";
  home.homeDirectory = "/home/akashg";

  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    # Add packages if needed
  
    # development
    rustc
    git
    zsh
   
    # music
    spotify

    # communication
    discord-canary
  ];
  

  home.file = {
    # Add dotfile management if needed
  };

  home.sessionVariables = {
    # Add environment variables if needed
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    TERM = "kitty";
  };

  programs.home-manager.enable = true;

    # Imports
  imports = [
   
    inputs.nix-flatpak.homeManagerModules.nix-flatpak
     ../../user/lang/python/python.nix # C and C++ tools
    ../../user/lang/cc/cc.nix # C and C++ tools
    ../../user/app/git/git.nix # My git config
    ../../user/app/flatpak/flatpak.nix # Flatpak
    ../../user/shell/sh.nix # My zsh and bash config
    ../../user/shell/cli-collections.nix # Useful CLI apps
    inputs.plasma-manager.homeManagerModules.plasma-manager
  ];

  
  programs.plasma = {
    enable = true;

     workspace = {
      clickItemTo = "open"; # If you liked the click-to-open default from plasma 5
      lookAndFeel = "org.kde.breezedark.desktop";
      };
    };


}

