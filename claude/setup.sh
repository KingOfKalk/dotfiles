#!/usr/bin/env bash
set -euo pipefail

log() { printf "[claude] %s\n" "$1"; }

if [ ! -d ~/.claude ]; then
  log "Creating ~/.claude"
  mkdir -p ~/.claude
fi

log "Adding plugin marketplace"
claude plugin marketplace add KingOfKalk/claude_code_plugins

log "Installing plugins"
claude plugin install commit@KingOfKalk:claude_code_plugins
claude plugin install docker@KingOfKalk:claude_code_plugins
claude plugin install docker-compose@KingOfKalk:claude_code_plugins
claude plugin install statusline@KingOfKalk:claude_code_plugins

log "Done."
