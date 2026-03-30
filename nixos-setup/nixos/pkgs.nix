{ pkgs, ... }:

{
# 1. System-wide packages (available to all users and the OS)
  environment.systemPackages = with pkgs; [
    bzip2
      coreutils
      curl
      direnv
      fish
      gawk
      gcc            # C compiler for tiktoken_core
      gdbm
      gnumake        # Required if you want the plugin to build itself
      gnupg
      hostname
      libffi
      libyaml
      ncurses
      openssh
      openssl
      patch
      pinentry-curses
      python3
      readline
      unzip
      wget
      wl-clipboard
      xz
      zlib
      zsh
      ];

# 2. User-specific tools (installed via Home Manager)
  home-manager.users.hery = { pkgs, ... }: {
    home.packages = with pkgs; [
      chromium
        ctags
        fd
        fzf
        gh
        git
        keychain
        lynx           # For URL fetching in CopilotChat
        neovim
        nodejs
        poppler-utils
        postgresql
        rcm
        redis
        ripgrep
        ruby
        shellcheck
        tmux
        tree-sitter
        zoxide
        vips

# --- Neovim Linters & Formatters ---
        markdownlint-cli2
        markdown-toc
        prettier
        rubyPackages.rubocop
        rubyPackages.ruby-lsp
        shfmt
        sqlfluff
        stylua
        ];
    home.stateVersion = "23.11";
  };
}

