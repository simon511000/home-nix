{ pkgs }: with pkgs; [
    nodePackages.bash-language-server
    clang-tools
    lldb
    cmake-language-server
    nodePackages.vscode-langservers-extracted
    dart
    nodePackages.dockerfile-language-server-nodejs
    nodePackages.typescript-language-server
    nil
    nodePackages.intelephense
    python311Packages.python-lsp-server
    rust-analyzer
    nodePackages.vls
    nodePackages.yaml-language-server
]
