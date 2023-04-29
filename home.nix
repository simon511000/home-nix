{ config, pkgs, lib, ... }:

let
  catppuccin = pkgs.catppuccin-gtk.override {
    accents = [ "red" ];
    size = "standard";
    tweaks = [ "normal" ];
    variant = "macchiato";
  };
  catppuccin-bat = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "bat";
    rev = "ba4d16880d63e656acced2b7d4e034e4a93f74b1";
    sha256 = "6WVKQErGdaqb++oaXnY3i6/GuH2FhTgK0v4TN4Y0Wbw=";
  };
in
{
  targets.genericLinux.enable = true;

  home.username = "simon";
  home.homeDirectory = "/var/home/simon";

  home.stateVersion = "22.11";

  home.packages = with pkgs; [
    neofetch
    guake
    btop
    zsh-powerlevel10k
    exa
    mononoki (nerdfonts.override { fonts = [ "Ubuntu" ]; })
  ];

  home.file = {
    ".config/autostart/autostart-guake.desktop".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.nix-profile/share/guake/autostart-guake.desktop";

    ".config/gtk-4.0/gtk.css".source = "${catppuccin}/share/themes/Catppuccin-Macchiato-Standard-Red-Dark/gtk-4.0/gtk.css";
    ".config/gtk-4.0/gtk-dark.css".source = "${catppuccin}/share/themes/Catppuccin-Macchiato-Standard-Red-Dark/gtk-4.0/gtk-dark.css";
    ".config/gtk-4.0/assets" = {
      recursive = true;
      source = "${catppuccin}/share/themes/Catppuccin-Macchiato-Standard-Red-Dark/gtk-4.0/assets";
    };
  };

  home.pointerCursor = {
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = 16;
    gtk.enable = true;
    x11.enable = true;
  };

  home.sessionVariables = {
    EDITOR = "nano";
  };

  xdg.enable = true;

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "Simon Ledoux";
    userEmail = "simon@simon511000.fr";
  };

  programs.zsh = {
    enable = true;
    shellAliases = {
      cat = "bat";
      ls = "exa -lah --group-directories-first";
    };
    
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = lib.cleanSource ./p10k-config;
        file = "p10k.zsh";
      }
    ];

    oh-my-zsh = {
      enable = false;
    };
  };

  programs.vscode = {
    enable = true;
  };

  programs.bat = {
    enable = true;
    themes.Catppuccin-macchiato = builtins.readFile "${catppuccin-bat}/Catppuccin-macchiato.tmTheme";
    config.theme = "Catppuccin-macchiato";
  };

  gtk = {
    enable = true;
    font = {
      name = "ubuntu Nerd Font";
      package = null;
      size = 12;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    theme = {
      name = "Catppuccin-Macchiato-Standard-Red-Dark";
      package = catppuccin;
    };
  };
}
