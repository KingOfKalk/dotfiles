#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
TEST_SCRIPT="test.sh"

log() { printf "[dotfiles] %s\n" "$1"; }

log "Starting dotfiles tests from: ${SCRIPT_DIR}"

passed=()
failed=()
for dir in "${SCRIPT_DIR}"/*/; do
  [ -d "${dir}" ] || continue
  if [ -f "${dir}${TEST_SCRIPT}" ]; then
    name="$(basename "${dir}")"
    log "Running ${dir}${TEST_SCRIPT}"
    if (cd "${dir}" && bash "${TEST_SCRIPT}"); then
      passed+=("${name}")
    else
      failed+=("${name}")
    fi
  fi
done

log "Summary: ${#passed[@]} passed, ${#failed[@]} failed."
for name in "${passed[@]}"; do
  log "  PASS ${name}"
done
for name in "${failed[@]}"; do
  log "  FAIL ${name}"
done

[ "${#failed[@]}" -eq 0 ]
