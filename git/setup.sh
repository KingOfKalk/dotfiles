#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

log() { printf "[git] %s\n" "$1"; }

log "Copying .gitignore to ~/.gitignore"
cp "${SCRIPT_DIR}/.gitignore" ~/.gitignore

log "Configure git via XDG (~/.config/git/config) so VS Code can still copy host ~/.gitconfig"
mkdir -p ~/.config/git
GIT_CFG=~/.config/git/config
git config --file "${GIT_CFG}" core.excludesFile '~/.gitignore'
git config --file "${GIT_CFG}" pull.rebase true
git config --file "${GIT_CFG}" push.autoSetupRemote true

log "Done."
