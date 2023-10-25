{pkgs, ...}:

{
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
}