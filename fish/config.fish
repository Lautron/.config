#neofetch
set fish_greeting # Supresses fish's intro message

function fish_user_key_bindings
  # fish_default_key_bindings
  fish_vi_key_bindings
end

set -x EDITOR "nvim"
set -x VISUAL "nvim"
set -x BROWSER "thorium-browser"
set -x SUDO_ASKPASS "$HOME/.config/scripts/dmenupass sudo -A dmenu"
set -x PATH "/home/lautarob/.config/scripts" $PATH
set -x PATH "/usr/lib/jvm/java-11-openjdk/bin" $PATH
#pyenv
#set -x PATH "/home/lautarob/.pyenv/bin" $PATH
#status --is-interactive; and . (pyenv init -|psub)
#status --is-interactive; and . (pyenv virtualenv-init -|psub)

### AUTOCOMPLETE AND HIGHLIGHT COLORS ###
set fish_color_normal brcyan
set fish_color_autosuggestion '#7d7d7d'
set fish_color_command brcyan
set fish_color_error '#ff6c6b'
set fish_color_param brcyan

# Functions needed for !! and !$
function __history_previous_command
  switch (commandline -t)
  case "!"
    commandline -t $history[1]; commandline -f repaint
  case "*"
    commandline -i !
  end
end

function __history_previous_command_arguments
  switch (commandline -t)
  case "!"
    commandline -t ""
    commandline -f history-token-search-backward
  case "*"
    commandline -i '$'
  end
end
# The bindings for !! and !$
if [ $fish_key_bindings = fish_vi_key_bindings ];
  bind -Minsert ! __history_previous_command
  bind -Minsert '$' __history_previous_command_arguments
else
  bind ! __history_previous_command
  bind '$' __history_previous_command_arguments
end

# Function to go to code folder
function cdc
    set argument $argv .
    cd ~/Documents/code/$argument[1]
end

function lolban
    toilet -f pagga $argv | lolcat
end

alias fug='nvim +Git +only'
alias ff="nvim +'Telescope find_files'"
alias newmake='nvim makefile -c ":normal ictemp"'

# navigation
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'
alias home='cd ~'

# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

## get top process eating memory
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'

## get top process eating cpu ##
alias pscpu='ps auxf | sort -nr -k 3'
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'

# the terminal rickroll
alias rr='curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash'
alias mp='sudo mpdeploy .'
alias mpe='sudo mpdeploy --execute-job .'
alias mpd='sudo mpdeploy --run-docker .'
alias pvenv='python3.10 -m venv venv && venv && pip install -r requirements.txt'

function venv
    if test -d "venv"
        source venv/bin/activate.fish
    end
end

set -x CLOUDSDK_ROOT_DIR /opt/google-cloud-cli
set -x CLOUDSDK_PYTHON /usr/bin/python
set -x CLOUDSDK_PYTHON_ARGS -S
set -x PATH $CLOUDSDK_ROOT_DIR/bin $PATH
set -x GOOGLE_CLOUD_SDK_HOME $CLOUDSDK_ROOT_DIR
