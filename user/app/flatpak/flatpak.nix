{ pkgs, inputs,... }:

{  

  imports = [inputs.nix-flatpak.homeManagerModules.nix-flatpak];

  home.packages = [ pkgs.flatpak ];
  home.sessionVariables = {
    XDG_DATA_DIRS = "$XDG_DATA_DIRS:/usr/share:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share"; # lets flatpak work
  };

  services.flatpak.enable = true;
  services.flatpak.packages = [ { appId = "org.videolan.VLC"; origin = "flathub";  } ];
  #services.flatpak.update.onActivation = true;
}

