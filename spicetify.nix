{ pkgs, spicetify-nix, ... }:
let
  spicePkgs = spicetify-nix.packages.${pkgs.system}.default;
in
{
  # import the flake's module for your system
  imports = [ spicetify-nix.homeManagerModule ];

  # configure spicetify :)
  programs.spicetify =
    {
      enable = true;
      theme = {
        name = "catppuccin";
        appendName = true;
        src = pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "spicetify";
          rev = "dc3d4b24dcdd2fc3a8aa716d6280047c1928c029";
          sha256 = "sha256-XqsPnr0BiTHKgz6G6YOPT8+iSJMxkKHD2MEJBVdZk6w=";
        };
        injectCss = true;
        replaceColors = true;
        overwriteAssets = true;
        sidebarConfig = false;
      };
      colorScheme = "macchiato";

      enabledExtensions = with spicePkgs.extensions; [
        shuffle
        history
      ];
    };
}