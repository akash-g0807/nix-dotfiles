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
}

