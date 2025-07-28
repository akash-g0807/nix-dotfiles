{config, pkgs, inputs, ... }:

{
    hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver   # Modern Intel GPUs
      vaapiIntel           # Legacy fallback
      vaapiVdpau
      libvdpau-va-gl
      vulkan-tools
    ];
  };

   hardware.opengl.driSupport32Bit = true;

     services.xserver.videoDrivers = ["intel"];
  # hardware.opengl has beed changed to hardware.graphics
  
  # Steam
  programs.steam = {
    enable = true;
  };

  # Lutris
  environment.systemPackages = with pkgs; [
    lutris
    mangohud
    wineWowPackages.staging
    winetricks
    gamemode
    protonup-qt
    bottles
    heroic
    steam-run
    vkbasalt
  ];

  # Gamepad support
  hardware.steam-hardware.enable = true;
  services.udev.packages = with pkgs; [ 
    game-devices-udev-rules 
  ];

  # Gaming performance tools
  programs.gamemode.enable = true;

  # Vulkan
  hardware.opengl.extraPackages = with pkgs; [
    vulkan-tools
    vulkan-validation-layers
  ];


}

