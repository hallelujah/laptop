Laptop
======

Laptop is a script to set up a machine for web and mobile development.
It supports macOS, Fedora, and NixOS.

It can be run multiple times on the same machine safely.
It installs, upgrades, or skips packages
based on what is already installed on the machine.

Requirements
------------

We support:

* macOS Sequoia (15.x) on Apple Silicon and Intel
* macOS Sonoma (14.x) on Apple Silicon and Intel
* macOS Ventura (13.x) on Apple Silicon and Intel
* macOS Monterey (12.x) on Apple Silicon and Intel
* Linux Fedora 43
* NixOS

Older versions may work but aren't regularly tested.
Bug reports for older versions are welcome.

Install
-------

Clone the repository:

```sh
git clone https://github.com/hallelujah/laptop.git ~/laptop
cd ~/laptop
```

Review the script (avoid running scripts you haven't read!):

```sh
less mac
# or
less fedora
# or
less nixos
```

Execute the script:

```sh
sh mac 2>&1 | tee ~/setup.log
# or
sh fedora 2>&1 | tee ~/setup.log
# or
sh nixos 2>&1 | tee ~/setup.log
```

Optionally, review the log:

```sh
less ~/setup.log
```

Optionally, [install thoughtbot/dotfiles][dotfiles].

[dotfiles]: https://github.com/thoughtbot/dotfiles#install

Debugging
---------

Your last run will be saved to `~/setup.log`.
Read through it to see if you can debug the issue yourself.
If not, copy the lines where the script failed into a
[new GitHub Issue](https://github.com/thoughtbot/laptop/issues/new) for us.
Or, attach the whole log file as an attachment.

What it sets up
---------------

macOS tools:

* [Homebrew] for managing operating system libraries.

[Homebrew]: http://brew.sh/

Unix tools:

* [fzf][] for better command history searching
* [Universal Ctags] for indexing files for neovim tab completion
* [Git] for version control
* [OpenSSL] for Transport Layer Security (TLS)
* [RCM] for managing company and personal dotfiles
* [ripgrep] for finding things in files
* [Tmux] for saving project state and switching between projects
* [Watchman] for watching for filesystem events
* [Zsh] as your shell

[fzf]: https://github.com/junegunn/fzf
[Universal Ctags]: https://ctags.io/
[Git]: https://git-scm.com/
[OpenSSL]: https://www.openssl.org/
[RCM]: https://github.com/thoughtbot/rcm
[ripgrep]: https://github.com/BurntSushi/ripgrep
[Tmux]: http://tmux.github.io/
[Watchman]: https://facebook.github.io/watchman/
[Zsh]: http://www.zsh.org/

Heroku tools:

* [Heroku CLI] and [Parity] for interacting with the Heroku API

[Heroku CLI]: https://devcenter.heroku.com/articles/heroku-cli
[Parity]: https://github.com/thoughtbot/parity

GitHub tools:

* [GitHub CLI] for interacting with the GitHub API

[GitHub CLI]: https://cli.github.com/

Image tools:

* [libvips] for cropping and resizing images

Programming languages, package managers, and configuration:

* [mise] for managing programming language versions (macOS and Fedora)
* [Bundler] for managing Ruby libraries
* [Node.js] and [npm], for running apps and installing JavaScript packages (managed by `mise` on macOS and Fedora, system packages on NixOS via `install.nix`)
* [Ruby] stable for writing general-purpose code (managed by `mise` on macOS and Fedora, system package on NixOS via `install.nix`)
* [Yarn] for managing JavaScript packages
* [Rosetta 2] for running tools that are not supported in Apple silicon processors
* [Nix] for declarative package management on NixOS via `install.nix`

[Bundler]: http://bundler.io/
[libvips]: https://www.libvips.org/
[Node.js]: http://nodejs.org/
[npm]: https://www.npmjs.org/
[mise]: https://mise.jdx.dev/
[Nix]: https://nixos.org/
[Ruby]: https://www.ruby-lang.org/en/
[Yarn]: https://yarnpkg.com/en/
[Rosetta 2]: https://developer.apple.com/documentation/apple-silicon/about-the-rosetta-translation-environment

Databases:

* [Postgres] for storing relational data
* [Redis] for storing key-value data

[Postgres]: http://www.postgresql.org/
[Redis]: http://redis.io/

Direnv:

* [direnv] for managing environment variables

[direnv]: https://github.com/direnv/direnv

Docker:

* [Docker] for containers

[Docker]: https://www.docker.com

pinentry-mac:

* [pinentry-mac] for containers

[pinentry-mac]: https://github.com/GPGTools/pinentry


It should take less than 15 minutes to install (depends on your machine).

Customize in `~/.setup.local`
------------------------------

Your `~/.setup.local` is run at the end of the script.
Put your customizations there.
For example:

```sh
#!/bin/sh

brew bundle --file=- <<EOF
brew "Caskroom/cask/dockertoolbox"
brew "go"
brew "ngrok"
brew "watch"
EOF

default_docker_machine() {
  docker-machine ls | grep -Fq "default"
}

if ! default_docker_machine; then
  docker-machine create --driver virtualbox default
fi

default_docker_machine_running() {
  default_docker_machine | grep -Fq "Running"
}

if ! default_docker_machine_running; then
  docker-machine start default
fi

fancy_echo "Cleaning up old Homebrew formulae ..."
brew cleanup

if [ -r "$HOME/.rcrc" ]; then
  fancy_echo "Updating dotfiles ..."
  rcup
fi
```

Write your customizations such that they can be run safely more than once.
See the `mac` script for examples.

Laptop functions such as `fancy_echo` and
`gem_install_or_update`
can be used in your local customization script.

See the [wiki](https://github.com/thoughtbot/laptop/wiki)
for more customization examples.

Contributing
------------

Thank you, [contributors]!

[contributors]: https://github.com/thoughtbot/laptop/graphs/contributors

By participating in this project,
you agree to abide by the thoughtbot [code of conduct].

[code of conduct]: https://thoughtbot.com/open-source-code-of-conduct

Edit the `mac` file.
Document in the `README.md` file.
Update the `CHANGELOG`.
Follow shell style guidelines by using [ShellCheck] and [NeoVim] with [ALE] or deprecated [Syntastic].

```sh
brew install shellcheck
```

[ShellCheck]: http://www.shellcheck.net/about.html
[Syntastic]: https://github.com/scrooloose/syntastic
[ALE]: https://github.com/dense-analysis/ale
[NeoVim]: https://neovim.io/


### Testing your changes

Test your changes by running the script on a fresh install of macOS.
You can use the free and open source emulator [UTM].

Tip: Make a fresh virtual machine with the installation of macOS completed and
your user created and first launch complete. Then duplicate that machine to test
the script each time on a fresh install that's ready to go.

[UTM]: https://mac.getutm.app

License
-------

Copyright © 2011 thoughtbot, inc.
It is free software,
and may be redistributed under the terms specified in the [LICENSE] file.

[LICENSE]: LICENSE

<!-- START /templates/footer.md -->
## About thoughtbot

![thoughtbot](https://thoughtbot.com/thoughtbot-logo-for-readmes.svg)

This repo is maintained and funded by thoughtbot, inc.
The names and logos for thoughtbot are trademarks of thoughtbot, inc.

We love open source software!
See [our other projects][community].
We are [available for hire][hire].

[community]: https://thoughtbot.com/community?utm_source=github
[hire]: https://thoughtbot.com/hire-us?utm_source=github

<!-- END /templates/footer.md -->
