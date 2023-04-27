{ config, pkgs, lib, ... }:

{
  home.username = "simon";
  home.homeDirectory = "/var/home/simon";

  home.stateVersion = "22.11";

  home.packages = with pkgs; [
    neofetch
    guake
    btop
    zsh-powerlevel10k
  ];

  home.file = {
    ".config/autostart/autostart-guake.desktop".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.nix-profile/share/guake/autostart-guake.desktop";

    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/simon/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    EDITOR = "nano";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "Simon Ledoux";
    userEmail = "simon@simon511000.fr";
  };

  # programs.fish = {
  #   enable = true;
  #   interactiveShellInit = ''
  #     set fish_greeting # Disable greeting
  #   '';
  #   shellAliases = {
  #     cat = "bat";
  #   };
  # };

  programs.zsh = {
    enable = true;
    shellAliases = {
      cat = "bat";
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
}
