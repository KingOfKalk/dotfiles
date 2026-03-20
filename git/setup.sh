#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

log() { printf "[git] %s\n" "$1"; }

log "Copying .gitignore to ~/.gitignore"
cp "${SCRIPT_DIR}/.gitignore" ~/.gitignore

log "Configure git globally"
git config --global core.excludesFile '~/.gitignore'
git config --global pull.rebase true
git config --global push.autoSetupRemote true

log "Done."
