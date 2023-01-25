#!/bin/bash
pip_packages="neovim auto-editor termdown togglCli"
success="DONE\n"

source log-status "Installing paru..."
[ -x "$(command -v paru)" ] || source install_paru.sh
source log-status "$success"

source log-status "Update mirrors..."
paru -Sy --needed --noconfirm reflector
sudo reflector --latest 5 --sort rate --save /etc/pacman.d/mirrorlist
source log-status "$success"

source log-status "Installing packages.."
paru -Sy --needed --noconfirm - < aur-pkgs.txt
source log-status "$success"

source log-status "Setting git credentials..."
git config --global user.email "laurigbach@gmail.com"
git config --global user.name "Lautaro Bachmann"
source log-status "$success"

source log-status "Setting up xmonad..."
# create .xmonad if it does not exist
[  ~/.xmonad ] || mkdir ~/.xmonad
# create hard link for xmonad.hs
[ -f ~/.xmonad/xmonad.hs ] || ln ~/.config/xmonad/xmonad.hs ~/.xmonad/ 
# compile xmonad
xmonad --recompile
source log-status "$success"

# enable ly display manager
source log-status "Enabling display manager..."
systemctl is-active --quiet ly.service || sudo systemctl enable ly.service 
source log-status "$success"

# set up fish
source log-status "Setting up fish..."
[ ${SHELL: -4} == "fish" ] || chsh -s $(which fish)
source log-status "$success"

# Ensure pip is installed
source log-status "Installing python packages..."
[ -f ~/.local/bin/pip3 ] || python3 -m ensurepip && pip install $pip_packages
source log-status "$success"

