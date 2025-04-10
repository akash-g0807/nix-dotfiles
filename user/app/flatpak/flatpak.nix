{ pkgs, inputs,... }:

{  

  home.packages = [ pkgs.flatpak ];
  home.sessionVariables = {
    XDG_DATA_DIRS = "$XDG_DATA_DIRS:/usr/share:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share"; # lets flatpak work
  };

  services.flatpak.enable = true;
  services.flatpak.packages = [ { appId = "org.videolan.VLC"; origin = "flathub";  } 
  "com.rtosta.zapzap"
  "com.spotify.Client"
  "org.libreoffice.LibreOffice"
  "org.gtk.Gtk3theme.Adwaita-dark"
  ];
  #services.flatpak.update.onActivation = true;
}

