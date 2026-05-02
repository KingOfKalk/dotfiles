#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

log() { printf "[vim] %s\n" "$1"; }

if ! command -v vim &>/dev/null; then
  if command -v apt-get &>/dev/null; then
    log "vim not found, installing via apt-get"
    SUDO=""
    if [ "$(id -u)" -ne 0 ]; then
      SUDO="sudo"
    fi
    export DEBIAN_FRONTEND=noninteractive
    ${SUDO} apt-get update
    ${SUDO} apt-get install -y vim
  else
    log "vim not found and apt-get unavailable, skipping install"
  fi
fi

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
  vim -E -s -u ~/.vimrc +PluginInstall +qall || true
else
  log "vim not found, skipping plugin install"
fi

log "Done."
