{
  description = "Home Manager configuration of simon";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland/424c9a7e704590db5c823557e5e388e366f7b1cd";
    hyprgrass = {
      url = "github:horriblename/hyprgrass/02e16882e321a794edf827d59b11fd9dd4d0ea28";
      inputs.hyprland.follows = "hyprland";
    };

    spicetify-nix.url = "github:the-argus/spicetify-nix";
  };

  outputs = { nixpkgs, home-manager, hyprland, ... } @ inputs:
    let
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
    in {
      homeConfigurations."simon" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [
          hyprland.homeManagerModules.default
          ./home.nix
          ./spicetify.nix
          ./spicetify.nix
        ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
        extraSpecialArgs = inputs;
      };
    };
}
