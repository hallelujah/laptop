# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Repo Is

`laptop` is an idempotent machine setup script for web and mobile development. A single `setup` entry point auto-detects the OS and delegates to `mac`, `fedora`, or `nixos` scripts. Scripts can safely run multiple times — they install, upgrade, or skip based on current state.

Supported targets: macOS (Apple Silicon & Intel), Fedora 43, NixOS (WSL).

## Running Setup

```sh
sh setup          # auto-detect OS and run appropriate script
sh mac            # macOS only
sh fedora         # Fedora only
sh nixos          # NixOS: runs nixos-rebuild switch --flake nixos-setup#nixos-laptop
```

User customizations go in `~/.setup.local` (sourced at the end of `setup`).

## NixOS / Flake Workflow

The NixOS configuration lives in `nixos-setup/`. After editing any `.nix` file, apply with:

```sh
sudo nixos-rebuild switch --flake nixos-setup#nixos-laptop
```

Key files:
- `nixos-setup/flake.nix` — inputs (nixpkgs unstable, nixos-wsl, home-manager, neovim-nightly-overlay)
- `nixos-setup/nixos/configuration.nix` — system config (WSL, SSH on port 8822, user `hery` uid 1001, hostname `nixos-laptop`)
- `nixos-setup/nixos/pkgs.nix` — system-wide packages (NixOS) and user packages (home-manager); also sets session variables and `.miserc.toml`

## Tool / Language Version Management

`mise` manages language runtimes and tools. Versions are declared in `config/mise/conf.d/core.toml`. Tools include: ast-grep, direnv, fd, fzf, gh, lua 5.1, neovim, node, postgres, redis, ripgrep, ruby, rust, tmux, tree-sitter, zoxide, plus `gem:overmind`.

On NixOS, `mise` is installed as a home-manager package and `.miserc.toml` sets `env=["nixos"]`.

## Architecture Notes

- `utils.sh` provides shared helpers (`fancy_echo`, `install_mise`, `run_local_customizations`, `number_of_cores`) sourced by all OS scripts.
- macOS uses Homebrew (`brew bundle`) for system packages; Fedora uses `dnf`; NixOS uses declarative Nix (home-manager for user packages).
- Shell scripts should pass `shellcheck` — it is installed on all platforms.
- Formatters available on NixOS: `shfmt` (shell), `prettier` (markdown/JS), `stylua` (Lua), `sqlfluff` (SQL), `markdownlint-cli2`.
