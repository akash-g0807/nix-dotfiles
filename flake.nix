{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        system = system;
        config.allowUnfree = true; # Enable unfree packages globally
      };
      
      ##### USER SETTINGD
      userSettings = rec {
          username = "akashg";
	  name = "Akash";
          email= "akash.gopinath008@gmail.com";
      };

       # ---- SYSTEM SETTINGS ---- #
      systemSettings = {
        system = "x86_64-linux"; # system arch
        hostname = "akash-linux"; # hostname
        profile = "default"; # select a profile defined from my profiles directory
      };

  
    in {
      nixosConfigurations.default = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; inherit systemSettings;
            inherit userSettings;};
        modules = [
          (./. + "/hosts" + ("/" + systemSettings.profile) + "/configuration.nix")
          inputs.home-manager.nixosModules.default
        ];

      };

      homeConfigurations = {
        akashg = inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = system;
            config.allowUnfree = true; # Enable unfree for home-manager too
          };
          extraSpecialArgs = { inherit inputs; inherit systemSettings;
            inherit userSettings;};
          modules = [
            (./. + "/hosts" + ("/" + systemSettings.profile) + "/home.nix")
            inputs.plasma-manager.homeManagerModules.plasma-manager
          ];
        };
      };
    };
}

