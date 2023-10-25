{pkgs, lib, ...}:

{
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
}