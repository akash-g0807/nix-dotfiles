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
    dconf
  ];
  

  home.file = {
    # Add dotfile management if needed
  };

  home.sessionVariables = {
    # Add environment variables if needed
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    TERM = "kitty";
    NIXOS_OZONE_WL = "1";
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    _JAVA_AWT_WM_NONREPARENTING = "1";
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
  ];

  dconf = {
     enable = true;
     settings = { "org/gnome/desktop/interface" = {
      icon-theme = "Adwaita";  # Use any installed theme like 'Papirus', 'Breeze', etc.
      cursor-theme = "Adwaita";  # Set the cursor theme declaratively
    };

   "org/gnome/mutter" = {
      experimental-features = [ "scale-monitor-framebuffer" "xwayland-native-scaling"];  # Enables fractional scaling
    };
   "org/gnome/mutter" = {
      "enable-native-xwayland" = true;
    };
   };

 };
}

