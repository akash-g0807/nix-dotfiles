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

  # Include Plasma Manager here
  imports = [
    inputs.plasma-manager.homeManagerModules.plasma-manager
  ];

  programs.plasma = {
    enable = true;

  };

}

