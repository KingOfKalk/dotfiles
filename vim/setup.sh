#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

log() { printf "[vim] %s\n" "$1"; }

log "Copying .vimrc to ~"
cp "${SCRIPT_DIR}/.vimrc" ~/.vimrc

VUNDLE_DIR=~/.vim/bundle/Vundle.vim

if [ -d "${VUNDLE_DIR}" ]; then
  log "Vundle already present, skipping clone"
else
  mkdir -p ~/.vim/bundle
  tmpdir="$(mktemp -d)"
  log "Cloning Vundle to ${tmpdir}"
  git clone https://github.com/VundleVim/Vundle.vim.git "${tmpdir}"
  log "Copying to ${VUNDLE_DIR}"
  cp -r "${tmpdir}" "${VUNDLE_DIR}"
  rm -rf "${tmpdir}"
fi

if command -v vim &>/dev/null; then
  log "Installing plugins"
  vim +PluginInstall +qall
else
  log "vim not found, skipping plugin install"
fi

log "Done."