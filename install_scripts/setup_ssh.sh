# Set up ssh key
ssh-keygen -t ed25519 -C "laurigbach@gmail.com"
exec ssh-agent bash &
ssh-add ~/.ssh/id_ed25519
which xclip || sudo pacman -S xclip
xclip -selection clipboard < ~/.ssh/id_ed25519.pub
echo ""
echo "Ssh public key copied to clipboard"
sudo systemctl start sshd 
sudo systemctl enable sshd

