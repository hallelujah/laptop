{ pkgs, inputs, ... }:

{
  nixpkgs.overlays = [
    inputs.neovim-nightly-overlay.overlays.default
  ];
# 1. System-wide packages (available to all users and the OS)
  environment.systemPackages = with pkgs; [
    bison
      bzip2
      coreutils
      curl
      direnv
      fish
      flex
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
      readline.dev
      unzip
      wget
      wl-clipboard
      wslu
      xz
      zlib
      zsh
      ];

  environment.sessionVariables = {
    BROWSER = "wslview";
  };

# 2. User-specific tools (installed via Home Manager)
  home-manager.users.hery = { pkgs, ... }: {
    home.packages = with pkgs; [
      chromium
        ast-grep
        ctags
        fd
        fzf
        gh
        git
        keychain
        lazygit
        lua5_1
        lynx           # For URL fetching in CopilotChat
        mise
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
        shfmt
        sqlfluff
        stylua
        ];

    home.file.".miserc.toml".text = ''
      env = ["nixos"]
      '';

    home.stateVersion = "23.11";
  };
}

