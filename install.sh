#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SETUP_SCRIPT="setup.sh"

log() { printf "[dotfiles] %s\n" "$1"; }

log "Starting dotfiles install from: ${SCRIPT_DIR}"

found=0
for dir in "${SCRIPT_DIR}"/*/; do
  [ -d "${dir}" ] || continue
  if [ -f "${dir}${SETUP_SCRIPT}" ]; then
    found=$((found + 1))
    log "Running ${dir}${SETUP_SCRIPT}"
    (cd "${dir}" && bash "${SETUP_SCRIPT}")
    log "Done: ${dir}${SETUP_SCRIPT}"
  fi
done

log "Finished. Ran ${found} setup script(s)."