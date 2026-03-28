# shellcheck disable=SC3043

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

number_of_cores() {
  if [ "$(uname -s)" = "Darwin" ]; then
    sysctl -n hw.ncpu
  else
    nproc
  fi
}

fancy_echo() {
  local fmt="$1"
  shift

  # shellcheck disable=SC2059
  printf "\\n$fmt\\n" "$@"
}

# Mise installation
install_mise() {
  if ! command -v mise >/dev/null; then
    fancy_echo "Installing mise ..."
    curl https://mise.run | sh

    export PATH="$HOME/.local/bin:$PATH"
  fi

  fancy_echo "Copying configuration files ..."
  mkdir -p "$HOME/.config"
  cp -R $SCRIPT_DIR/config/* "$HOME/.config/"

  fancy_echo "Installing packages via mise ..."
  mise install

  fancy_echo "Configuring RubyGems"
  mise exec ruby@latest -- bundle config set --global jobs $((number_of_cores - 1))
  mise exec ruby@latest -- gem update --system
}

run_local_customizations() {
  if [ -f "$HOME/.setup.local" ]; then
    fancy_echo "Running your customizations from ~/.setup.local ..."
    # shellcheck disable=SC1091
    . "$HOME/.setup.local"
  fi
}
