#!/usr/bin/env bash
set -euo pipefail

log() { printf "[claude] %s\n" "$1"; }

failures=0
pass() { log "PASS $1"; }
fail() {
  log "FAIL $1"
  failures=$((failures + 1))
}

if [ -s ~/.claude/CLAUDE.md ]; then
  pass "~/.claude/CLAUDE.md exists"
else
  fail "~/.claude/CLAUDE.md missing or empty"
fi

if command -v claude &>/dev/null; then
  plugins="$(claude plugin list 2>&1 || true)"
  if grep -qw "superpowers" <<<"${plugins}"; then
    pass "plugin superpowers installed"
  else
    fail "plugin superpowers missing from 'claude plugin list'"
  fi
else
  log "SKIP claude not found, skipping plugin check"
fi

[ "${failures}" -eq 0 ]
