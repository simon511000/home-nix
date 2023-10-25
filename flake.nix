{
  description = "Home Manager configuration of simon";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix.url = "github:the-argus/spicetify-nix";
  };

  outputs = { nixpkgs, home-manager, ... } @ inputs:
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
          ./home.nix
          ./neovim.nix
          ./spicetify.nix
          ./zsh.nix
        ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
        extraSpecialArgs = inputs;
      };
    };
}
