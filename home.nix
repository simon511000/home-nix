{ config, pkgs, ... }:

let
  catppuccin = pkgs.catppuccin-gtk.override {
    accents = [ "red" ];
    size = "standard";
    tweaks = [ "normal" ];
    variant = "macchiato";
  };
  lsp = (import ./lsp.nix) { inherit pkgs; };
in
{
  targets.genericLinux.enable = true;

  home.username = "simon";
  home.homeDirectory = "/var/home/simon";

  home.stateVersion = "22.11";

  home.packages = with pkgs; [
    btop
    eza
    fastfetch 
    guake
    veracrypt
    yq
    zsh-powerlevel10k
  ] ++ lsp;

  home.file = {
    ".config/autostart/autostart-guake.desktop".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.nix-profile/share/guake/autostart-guake.desktop";

    ".config/gtk-4.0/gtk.css".source = "${catppuccin}/share/themes/Catppuccin-Macchiato-Standard-Red-Dark/gtk-4.0/gtk.css";
    ".config/gtk-4.0/gtk-dark.css".source = "${catppuccin}/share/themes/Catppuccin-Macchiato-Standard-Red-Dark/gtk-4.0/gtk-dark.css";
    ".config/gtk-4.0/assets" = {
      recursive = true;
      source = "${catppuccin}/share/themes/Catppuccin-Macchiato-Standard-Red-Dark/gtk-4.0/assets";
    };
  };

  xdg.enable = true;

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "Simon Ledoux";
    userEmail = "simon@simon511000.fr";
  };

  programs.vscode = {
    enable = true;
  };

  programs.bat = {
    enable = true;
    themes = {
      Catppuccin-macchiato = {
        src = pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "bat";
          rev = "ba4d16880d63e656acced2b7d4e034e4a93f74b1";
          sha256 = "6WVKQErGdaqb++oaXnY3i6/GuH2FhTgK0v4TN4Y0Wbw=";
        };
        file = "Catppuccin-macchiato.tmTheme";
      };
    };
    config.theme = "Catppuccin-macchiato";
  };

  gtk = {
    enable = true;
    # font = {
    #   name = "ubuntu Nerd Font";
    #   package = null;
    #   size = 12;
    # };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    theme = {
      name = "Catppuccin-Macchiato-Standard-Red-Dark";
      package = catppuccin;
    };
  };

  programs.helix = {
    enable = true;
  };
}
