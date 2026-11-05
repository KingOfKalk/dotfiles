#!/usr/bin/env bash
set -euo pipefail

log() { printf "[agent-instructions] %s\n" "$1"; }

tmpdir="$(mktemp -d)"
# Remove the clone even if a step below fails.
trap 'rm -rf "${tmpdir}"' EXIT

log "Cloning agent-instructions to ${tmpdir}"
git clone --depth 1 --branch main https://github.com/KingOfKalk/agent-instructions.git "${tmpdir}"

log "Installing agent instructions"
(cd "${tmpdir}" && ./install.sh all --backup)

log "Cleaning up"
rm -rf "${tmpdir}"

log "Done."
