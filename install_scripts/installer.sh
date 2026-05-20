#!/bin/bash
#pip_packages="neovim auto-editor termdown togglCli"
success="DONE\n"

source log-status "Installing paru..."
[ -x "$(command -v paru)" ] || source install_paru.sh
source log-status "$success"

source log-status "Update mirrors..."
paru -Sy --needed --noconfirm reflector
sudo reflector --latest 5 --sort rate --save /etc/pacman.d/mirrorlist
source log-status "$success"

source log-status "Installing packages.."
paru -Sy --needed --noconfirm - < packages.86_64
paru -Sy --needed --noconfirm - < aur-pkgs.txt
source log-status "$success"

source log-status "Setting git credentials..."
git config --global user.email "laurigbach@gmail.com"
git config --global user.name "Lautaro Bachmann"
source log-status "$success"

source log-status "Setting up xmonad..."
# create .xmonad if it does not exist
[  $HOME/.xmonad ] || mkdir $HOME/.xmonad
# create hard link for xmonad.hs
[ -f $HOME/.xmonad/xmonad.hs ] || ln $HOME/.config/xmonad/xmonad.hs $HOME/.xmonad/
# compile xmonad
xmonad --recompile
source log-status "$success"

# enable ly display manager and configure TTY1
source log-status "Enabling display manager..."
systemctl is-active --quiet ly.service || sudo systemctl enable ly.service
sudo systemctl enable ly@tty1.service
sudo systemctl disable getty@tty1.service
source log-status "$success"

# set up fish
source log-status "Setting up zsh..."
[ ${SHELL: -4} == "zsh" ] || chsh -s $(which zsh)
source log-status "$success"

source log-status "Installing starship..."
sudo pacman -S --needed --noconfirm starship
source log-status "$success"

source log-status "Linking zsh configs..."
[ -f $HOME/.zshrc ] || ln -sf $HOME/.config/zsh/.zshrc $HOME/.zshrc
[ -f $HOME/.zshenv ] || ln -sf $HOME/.config/zsh/.zshenv $HOME/.zshenv
source log-status "$success"

# Ensure pip is installed
#source log-status "Installing python packages..."
#[ -f $HOME/.local/bin/pip3 ] || python3 -m ensurepip && pipx install $pip_packages
#source log-status "$success"

