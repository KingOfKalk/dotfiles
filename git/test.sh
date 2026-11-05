#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

log() { printf "[git] %s\n" "$1"; }

failures=0
pass() { log "PASS $1"; }
fail() {
  log "FAIL $1"
  failures=$((failures + 1))
}

if cmp -s "${SCRIPT_DIR}/.gitignore" ~/.gitignore; then
  pass "~/.gitignore matches repo"
else
  fail "~/.gitignore missing or differs from repo"
fi

GIT_CFG=~/.config/git/config

expect_config() {
  local key="$1" expected="$2" actual
  actual="$(git config --file "${GIT_CFG}" --get "${key}" || true)"
  if [ "${actual}" = "${expected}" ]; then
    pass "${key} = ${expected}"
  else
    fail "${key}: expected '${expected}', got '${actual}'"
  fi
}

if [ -f "${GIT_CFG}" ]; then
  pass "${GIT_CFG} exists"
  expect_config core.excludesFile '~/.gitignore'
  expect_config pull.rebase true
  expect_config push.autoSetupRemote true
else
  fail "${GIT_CFG} missing"
fi

[ "${failures}" -eq 0 ]
