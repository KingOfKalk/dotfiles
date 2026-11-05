#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SETUP_SCRIPT="setup.sh"

log() { printf "[dotfiles] %s\n" "$1"; }
err() { printf "[dotfiles] ERROR: %s\n" "$1" >&2; }

modules=()
for dir in "${SCRIPT_DIR}"/*/; do
  if [ -f "${dir}${SETUP_SCRIPT}" ]; then
    modules+=("$(basename "${dir}")")
  fi
done

list_modules() { printf "  - %s\n" "${modules[@]}"; }

usage() {
  printf "Usage: %s [MODULE...]\n\n" "$(basename "$0")"
  printf "Installs the given modules, or all modules if none are given.\n\n"
  printf "Available modules:\n"
  list_modules
}

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
  usage
  exit 0
fi

targets=()
if [ "$#" -eq 0 ]; then
  targets=("${modules[@]}")
else
  for arg in "$@"; do
    name="${arg%/}"
    if [[ " ${modules[*]} " == *" ${name} "* ]]; then
      targets+=("${name}")
    else
      err "Unknown module: '${arg}'"
      list_modules >&2
      exit 1
    fi
  done
fi

log "Starting dotfiles install from: ${SCRIPT_DIR}"

found=0
for name in "${targets[@]}"; do
  dir="${SCRIPT_DIR}/${name}/"
  found=$((found + 1))
  log "Running ${dir}${SETUP_SCRIPT}"
  (cd "${dir}" && bash "${SETUP_SCRIPT}")
  log "Done: ${dir}${SETUP_SCRIPT}"
done

log "Finished. Ran ${found} setup script(s)."
