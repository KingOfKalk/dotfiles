#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

log() { printf "[oh-my-zsh] %s\n" "$1"; }

failures=0
pass() { log "PASS $1"; }
fail() {
  log "FAIL $1"
  failures=$((failures + 1))
}

if command -v zsh &>/dev/null; then
  HAS_ZSH=1
else
  HAS_ZSH=0
  log "SKIP zsh not found, skipping syntax checks"
fi

while IFS= read -r -d '' src; do
  rel="${src#"${SCRIPT_DIR}/"}"
  dest=~/.oh-my-zsh/"${rel}"
  if cmp -s "${src}" "${dest}"; then
    pass "~/.oh-my-zsh/${rel} matches repo"
  else
    fail "~/.oh-my-zsh/${rel} missing or differs from repo"
    continue
  fi
  if [ "${HAS_ZSH}" -eq 1 ]; then
    if zsh -n "${dest}"; then
      pass "~/.oh-my-zsh/${rel} has valid zsh syntax"
    else
      fail "~/.oh-my-zsh/${rel} has invalid zsh syntax"
    fi
  fi
done < <(find "${SCRIPT_DIR}/custom" -type f -print0)

[ "${failures}" -eq 0 ]
