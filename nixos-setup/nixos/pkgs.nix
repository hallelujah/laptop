{ pkgs, ... }:

{
# 1. System-wide packages (available to all users and the OS)
  environment.systemPackages = with pkgs; [
    zsh
      coreutils
      gcc            # C compiler for tiktoken_core
      gnumake        # Required if you want the plugin to build itself
      openssh
      openssl
      curl
      wget
      gnupg
      direnv
      fish
      patch
      bzip2
      libffi
      zlib
      readline
      libyaml
      gdbm
      ncurses
      gawk
      pinentry-curses
      hostname
      xz
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
        nodePackages.markdown-toc
        nodePackages.prettier
        rubyPackages.rubocop
        shfmt
        sqlfluff
        stylua
        ];
    home.stateVersion = "23.11";
  };
}

