#!/usr/bin/env bash
set -euo pipefail

log() { printf "[claude] %s\n" "$1"; }

if [ ! -d ~/.claude ]; then
  log "Creating ~/.claude"
  mkdir -p ~/.claude
fi

log "Copying CLAUDE.md to ~/.claude"
cp "${SCRIPT_DIR}/CLAUDE.md" ~/.claude/

log "Done."
