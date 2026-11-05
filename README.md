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
./install.sh            # all modules
./install.sh git vim    # only the given modules, in that order
./install.sh --help     # usage and available modules
```

Without arguments, the install script iterates over each top-level directory, looks for a `setup.sh`, and executes it. With arguments, it only runs the `setup.sh` of the given modules. Unknown modules abort before anything is installed.

## Test

```bash
./test.sh
```

The test script iterates over each top-level directory, looks for a `test.sh`, and executes it. Each feature's `test.sh` verifies only what its own `setup.sh` did and skips checks for tools that aren't installed. The script prints a summary and exits non-zero if any feature test failed.

Set `JUNIT_OUTPUT=<path>` to also write a JUnit XML report.

CI runs `./install.sh` followed by `./test.sh` on every pull request and push to `main`, and publishes the JUnit report to the job summary.

## Visual Studio Code

See <https://code.visualstudio.com/docs/devcontainers/containers#_personalizing-with-dotfile-repositories> for how to wire this repo into your dev container automatically.
