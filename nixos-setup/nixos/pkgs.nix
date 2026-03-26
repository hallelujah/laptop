{ pkgs, ... }:

{
# 1. System-wide packages (available to all users and the OS)
  environment.systemPackages = with pkgs; [
    neovim
    curl
    wget
    git
    gnupg
    direnv
    openssh
    openssl
    rcm
    tmux
    ripgrep
    zsh
    fzf
    coreutils
    gcc
    gnumake
    fd
    fish
    lynx           # For URL fetching in CopilotChat
    gnumake        # Required if you want the plugin to build itself
    gcc            # C compiler for tiktoken_core
    lua51Packages.lua # Provides the headers for Neovim's LuaJIT
    tree-sitter
  ];

  # 2. User-specific tools (installed via Home Manager)
  home-manager.users.hery = { pkgs, ... }: {
    home.packages = with pkgs; [
      ctags
      zoxide
      gh
      vips
      poppler-utils
      libyaml
      patch
      bzip2
      libffi
      zlib
      postgresql
      redis
      readline
      gdbm
      ncurses
      gawk
      pinentry-curses
      hostname
      xz
      chromium
      shellcheck
      keychain
      ruby
      nodejs
    ];
    home.stateVersion = "23.11";
  };
}

