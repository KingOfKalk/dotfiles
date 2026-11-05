# Dotfiles

A collection of my (KingOfKalk) personal dotfiles. Useful both locally and inside a development container.

## Requirements

Some setup scripts install missing packages via `apt-get` when available (e.g. `vim`). On systems without `apt-get` those steps are skipped, so the dotfiles still work — you just need the underlying tools installed yourself.

## Features

- [claude](./claude/README.md)
- [git](./git/README.md)
- [oh-my-zsh](./oh-my-zsh/README.md)
- [vim](./vim/README.md)

## Install

```bash
./install.sh
```

The install script iterates over each top-level directory, looks for a `setup.sh`, and executes it.

## Visual Studio Code

See <https://code.visualstudio.com/docs/devcontainers/containers#_personalizing-with-dotfile-repositories> for how to wire this repo into your dev container automatically.
