# ZSH Starship & Plugin Setup

This guide covers setting up Starship prompt and syntax highlighting/autosuggestions plugins on Arch Linux.

## Prerequisites

1. Zsh installed: `sudo pacman -S zsh`
2. Make zsh your default shell:
   ```bash
   chsh -s /bin/zsh
   ```

## Symlink Zsh Config

Store `.zshrc` in `~/.config/zsh/` and symlink it to home:

```bash
mkdir -p ~/.config/zsh
ln -sf ~/.config/zsh/.zshrc ~/.zshrc
```

## Installing Starship

**Option A: Official installer (to user directory)**

```bash
BIN_DIR=~/.local/bin curl -sS https://starship.rs/install.sh | sh -s -- -y -b ~/.local/bin
```

**Option B: Via pacman**

```bash
sudo pacman -S starship
```

Add to `~/.zshrc`:

```sh
export PATH="$HOME/.local/bin:$PATH"  # Only needed if using Option A
eval "$(starship init zsh)"
```

## Installing Plugins

Install the required packages:

```bash
sudo pacman -S oh-my-zsh-git zsh-syntax-highlighting zsh-autosuggestions fzf
```

Symlink system plugins to oh-my-zsh:

```bash
ln -sf /usr/share/zsh/plugins/zsh-syntax-highlighting ~/.oh-my-zsh/plugins/zsh-syntax-highlighting
ln -sf /usr/share/zsh/plugins/zsh-autosuggestions ~/.oh-my-zsh/plugins/zsh-autosuggestions
```

If oh-my-zsh is missing the `tools` directory, copy it from system:

```bash
cp -r /usr/share/oh-my-zsh/tools ~/.oh-my-zsh/
```

## Zsh Configuration

Add to `~/.zshrc`:

```sh
# Oh-My-Zsh configuration
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""  # Disable default theme (using starship instead)
plugins=(fzf zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# Load syntax highlighting last (required)
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Starship prompt (at end of file)
export PATH="$HOME/.local/bin:$PATH"
eval "$(starship init zsh)"
```

## Testing

Restart zsh:

```bash
exec zsh
```

Verify plugins load:

```bash
zsh -l -c 'echo "OK"'
```

## Features

- **zsh-syntax-highlighting**: Valid commands green, invalid commands red
- **zsh-autosuggestions**: Gray suggestions as you type, right arrow to accept
- **fzf integration**: Ctrl+R for history, Ctrl+T for file search
- **Starship**: Cross-shell prompt with git, node, python, etc. modules