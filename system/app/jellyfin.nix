{config, pkgs, inputs, ... }:

{
  
   services.jellyfin = {
    enable = true;
    openFirewall = true;
    #user="akash-linux";
  };

  users.users.jellyfin = {
    extraGroups = [ "akashg" ];  # 👈 gives jellyfin access to your home
  };
 
 environment.systemPackages = [
    pkgs.jellyfin
    pkgs.jellyfin-web
    pkgs.jellyfin-ffmpeg
  ];
}



