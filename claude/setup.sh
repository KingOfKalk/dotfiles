#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

log() { printf "[claude] %s\n" "$1"; }

if [ ! -d ~/.claude ]; then
  log "Creating ~/.claude"
  mkdir -p ~/.claude
fi

tmpdir="$(mktemp -d)"
log "Cloning claude to ${tmpdir}"
git clone https://github.com/KingOfKalk/claude.git "${tmpdir}"

log "Copying CLAUDE.md to ~/.claude"
cp -r "${tmpdir}"/CLAUDE.md ~/.claude/.

log "Cleaning up"
rm -rf "${tmpdir}"

log "Done."
