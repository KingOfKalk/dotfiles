#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

log() { printf "[oh-my-zsh] %s\n" "$1"; }

if [ ! -d ~/.oh-my-zsh ]; then
  log "Creating ~/.oh-my-zsh"
  mkdir -p ~/.oh-my-zsh
fi

log "Copying custom to ~/.oh-my-zsh"
cp -r "${SCRIPT_DIR}/custom" ~/.oh-my-zsh

log "Done."