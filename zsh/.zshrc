# Oh-My-Zsh configuration
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""  # Disable default theme (using starship instead)
plugins=(fzf zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# Load syntax highlighting last (required)
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Suppress zsh greeting
export HISTFILE=~/.zsh_history

# Vi key bindings
bindkey -v

# Completion colors
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu select

# History expansion for !! and !$
setopt HIST_EXPAND

# venv function
venv() {
    if [ -d "venv" ]; then
        source venv/bin/activate
    fi
}

# Aliases
alias fug='nvim +G +only'
alias ff="nvim +'Telescope find_files'"
alias newmake='nvim makefile -c ":normal ictemp"'

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'
alias home='cd ~'

# Top process eating memory
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'

# Top process eating CPU
alias pscpu='ps auxf | sort -nr -k 3'
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'

# Rickroll
alias rr='curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash'

alias poe='uv run poe'
# Starship prompt
eval "$(starship init zsh)"
