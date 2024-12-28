{ config, pkgs, inputs, ... }:

{
  home.username = "akashg";
  home.homeDirectory = "/home/akashg";

  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    # Add packages if needed

  ];

  home.file = {
    # Add dotfile management if needed
  };

  home.sessionVariables = {
    # Add environment variables if needed
  };

  programs.home-manager.enable = true;

  programs.bash = {
    enable = true;
    shellAliases = {
      ll = "ls -la";
      ".." = "cd ..";
      "info" = "neofetch";
    };
  };

    # Include Plasma Manager here
  imports = [
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

