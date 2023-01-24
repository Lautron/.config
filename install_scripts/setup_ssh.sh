success="DONE\n"

# Set up ssh key
source log-status "Creating ssh key..."
ssh-keygen -t ed25519 -C "laurigbach@gmail.com"
source log-status "$success"

exec ssh-agent bash &

source log-status "Adding ssh key..."
ssh-add ~/.ssh/id_ed25519
source log-status "$success"

source log-status "Check if xclip is installed..."
which xclip || sudo pacman -S xclip
source log-status "$success"

source log-status "Copying ssh public key to clipboard..."
xclip -selection clipboard < ~/.ssh/id_ed25519.pub
source log-status "$success"

source log-status "Enabling ssh service..."
sudo systemctl start sshd 
sudo systemctl enable sshd
source log-status "$success"

