#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

log() { printf "[vim] %s\n" "$1"; }

failures=0
pass() { log "PASS $1"; }
fail() {
  log "FAIL $1"
  failures=$((failures + 1))
}

if cmp -s "${SCRIPT_DIR}/.vimrc" ~/.vimrc; then
  pass "~/.vimrc matches repo"
else
  fail "~/.vimrc missing or differs from repo"
fi

if [ -f ~/.vim/bundle/Vundle.vim/autoload/vundle.vim ]; then
  pass "Vundle installed"
else
  fail "Vundle missing in ~/.vim/bundle/Vundle.vim"
fi

if command -v vim &>/dev/null; then
  while IFS= read -r plugin; do
    name="${plugin##*/}"
    if [ -d ~/.vim/bundle/"${name}" ]; then
      pass "plugin ${plugin} installed"
    else
      fail "plugin ${plugin} missing in ~/.vim/bundle/${name}"
    fi
  done < <(sed -nE "s/^Plugin '([^']+)'.*/\1/p" "${SCRIPT_DIR}/.vimrc")

  if vim -N -u ~/.vimrc -i NONE -es -c 'qall!' </dev/null; then
    pass "~/.vimrc loads without errors"
  else
    fail "~/.vimrc reports errors on load"
  fi
else
  log "SKIP vim not found, skipping plugin and load checks"
fi

[ "${failures}" -eq 0 ]
