{ config, pkgs, lib, ... }:

let
  catppuccin = pkgs.catppuccin-gtk.override {
    accents = [ "green" ];
    size = "standard";
    tweaks = [ "normal" ];
    variant = "macchiato";
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
  };

  gtk = {
    enable = true;
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
