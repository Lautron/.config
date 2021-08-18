#!/bin/bash
# set git credentials
git config --global user.email "laurigbach@gmail.com"
git config --global user.name "Lautaro Bachmann"

# create .xmonad if it does not exist
[ -e ~/.xmonad ] || mkdir ~/.xmonad
# create hard link for xmonad.hs
[ -f ~/.xmonad/xmonad.hs ] || ln ~/.config/xmonad/xmonad.hs ~/.xmonad/ 
# compile xmonad
xmonad --recompile

# Install ly
paru -S ly

# enable ly display manager
systemctl is-active --quiet ly.service || sudo systemctl enable ly.service 

# set up fish
[ ${SHELL: -4} == "fish" ] || chsh -s $(which fish)

# Ensure pip is installed
# install neovim python module
[ -f ~/.local/bin/pip3 ] || python3 -m ensurepip && $(which pip3) install neovim

# Set up ssh key
ssh-keygen -t ed25519 -C "laurigbach@gmail.com"
exec ssh-agent bash &
ssh-add ~/.ssh/id_ed25519
which xclip || sudo pacman -S xclip
xclip -selection clipboard < ~/.ssh/id_ed25519.pub
echo ""
echo "Ssh public key copied to clipboard"
