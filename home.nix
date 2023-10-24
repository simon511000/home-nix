{ config, pkgs, lib, hyprgrass, ... }:

let
  catppuccin = pkgs.catppuccin-gtk.override {
    accents = [ "red" ];
    size = "standard";
    tweaks = [ "normal" ];
    variant = "macchiato";
  };
  lsp = (import ./lsp.nix) { inherit pkgs; };
  hyprland = (import ./hyprland.nix) { inherit pkgs; inherit hyprgrass; };
in
{
  targets.genericLinux.enable = true;

  home.username = "simon";
  home.homeDirectory = "/var/home/simon";

  home.stateVersion = "22.11";

  home.packages = with pkgs; [
    aria2
    bibata-cursors
    btop
    cascadia-code
    csvkit
    devbox
    eza
    fastfetch 
    guake
    hping
    lolcat
    ngrok
    nmap
    veracrypt
    xclip
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

  home.pointerCursor = {
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = 16;
    gtk.enable = true;
    x11.enable = true;
  };

  xdg.enable = true;

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "Simon Ledoux";
    userEmail = "simon@simon511000.fr";
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
      # LSP
      nvim-lspconfig

      # Completion
      nvim-cmp
      cmp-nvim-lsp

      # Theme
      catppuccin-nvim

      # Snippets
      luasnip
      cmp_luasnip

      # Tree
      nvim-tree-lua
      
    ];
    extraLuaConfig = builtins.readFile ./nvim/config.lua;
    extraPackages = with pkgs; [
      # LSP
      rnix-lsp
      nodePackages.typescript-language-server
      lua-language-server
    ];
  };

  programs.zsh = {
    enable = true;
    shellAliases = {
      cat = "bat";
      ls = "exa -lah --group-directories-first";
      neofetch = "fastfetch";
    };

    initExtra = ''
      bindkey  "^[[H"   beginning-of-line
      bindkey  "^[[F"   end-of-line
      bindkey  "^[[3~"  delete-char
      bindkey "^[[1;5C" forward-word
      bindkey "^[[1;5D" backward-word
      bindkey "^[[3;5~" kill-word
      bindkey   "^H"    backward-kill-word
      
      export PATH="/var/home/simon/.local/bin/:$PATH"
      
    '';
    
    enableAutosuggestions = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    
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

  wayland.windowManager.hyprland = hyprland;
}
