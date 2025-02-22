{config, pkgs, inputs, ... }:

{
  # Need some flatpaks
  services.flatpak.enable = true;
  xdg.portal.enable = true;
  
  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };

    services.flatpak.packages = [
    { appId = "org.freecad.FreeCAD"; origin = "flathub";  }
    #"org.libreoffice.LibreOffice"
    #"com.google.Chrome"
  ];
   
}


