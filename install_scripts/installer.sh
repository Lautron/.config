#!/bin/bash
COLOR='\033[0;32m'
NOCOLOR='\033[0m'
pip_packages="neovim auto-editor termdown togglCli"

function log-status() {
  echo -e "${COLOR}$1${NOCOLOR}"
}

log-status "Installing paru..."
[ -x "$(command -v paru)" ] || source install_paru.sh

log-status "Update mirrors..."
paru -Sy --needed --noconfirm reflector
sudo reflector --latest 5 --sort rate --save /etc/pacman.d/mirrorlist

log-status "Installing packages.."
paru -Sy --needed --noconfirm - < pacman-list.txt

log-status "Setting git credentials..."
git config --global user.email "laurigbach@gmail.com"
git config --global user.name "Lautaro Bachmann"

log-status "Setting up xmonad..."
# create .xmonad if it does not exist
[  ~/.xmonad ] || mkdir ~/.xmonad
# create hard link for xmonad.hs
[ -f ~/.xmonad/xmonad.hs ] || ln ~/.config/xmonad/xmonad.hs ~/.xmonad/ 
# compile xmonad
xmonad --recompile

# enable ly display manager
log-status "Enabling display manager..."
systemctl is-active --quiet ly.service || sudo systemctl enable ly.service 

# set up fish
log-status "Setting up fish..."
[ ${SHELL: -4} == "fish" ] || chsh -s $(which fish)

# Ensure pip is installed
log-status "Installing python packages..."
[ -f ~/.local/bin/pip3 ] || python3 -m ensurepip && pip install $pip_packages

