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
    #spotify

    # communication
    discord-canary
    dconf

   obsidian
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
    ../../user/gnome_extensions/extensions.nix #gnome extensions
    ../../user/app/vscode/vscode.nix #vscode config
  ];

  dconf = {
     enable = true;
     settings = { 
     "org/gnome/desktop/interface" = {
      icon-theme = "Adwaita";  # Use any installed theme like 'Papirus', 'Breeze', etc.
      cursor-theme = "Adwaita";  # Set the cursor theme declaratively
      gtk-theme = "Adwaita-dark";
    };
  
   "org/gnome/desktop/wm/preferences" = {
      theme = "Adwaita-dark";
    };

   "org/gnome/mutter" = {
      experimental-features = [ "scale-monitor-framebuffer" "xwayland-native-scaling"];  # Enables fractional scaling
       edge-tiling = true;  # Enables edge tiling (dragging windows to screen edges)
    };
   

  "org/gnome/mutter" = {
      "enable-native-xwayland" = true;
    };

    "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = [
          # Put UUIDs of extensions that you want to enable here.
          # If the extension you want to enable is packaged in nixpkgs,
          # you can easily get its UUID by accessing its extensionUuid
          # field (look at the following example).
          pkgs.gnomeExtensions.blur-my-shell.extensionUuid
          pkgs.gnomeExtensions.appindicator.extensionUuid
          pkgs.gnomeExtensions.dash-to-dock.extensionUuid

          # Alternatively, you can manually pass UUID as a string.  
          # ...
        ];
   };
   };

 };
}

