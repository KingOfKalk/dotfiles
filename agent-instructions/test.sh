#!/usr/bin/env bash
set -euo pipefail

log() { printf "[agent-instructions] %s\n" "$1"; }

failures=0
pass() { log "PASS $1"; }
fail() {
  log "FAIL $1"
  failures=$((failures + 1))
}

files=(
  "${HOME}/.claude/CLAUDE.md"
  "${XDG_CONFIG_HOME:-${HOME}/.config}/opencode/AGENTS.md"
  "${HOME}/.vibe/AGENTS.md"
  "${HOME}/.codex/AGENTS.md"
)

for file in "${files[@]}"; do
  pretty="${file/#"${HOME}"/\~}"
  if [ -s "${file}" ]; then
    pass "${pretty} exists"
  else
    fail "${pretty} missing or empty"
  fi
done

[ "${failures}" -eq 0 ]
