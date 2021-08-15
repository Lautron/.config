# create hard link for xmonad.hs
[ -f ~/.xmonad/xmonad.hs ] || ln ~/.config/xmonad/xmonad.hs ~/.xmonad/ 

# enable ly display manager
systemctl is-active --quiet ly.service || sudo systemctl enable ly.service 

# set up fish
[ ${SHELL: -4} == "fish" ] || chsh -s $(which fish)

# install neovim python module
python3 -m ensurepip &
[ -f /home/lautarob/.local/bin/pip3 ] && /home/lautarob/.local/bin/pip3 install neovim

