# Xmonad Pacman Hook Setup

## Purpose

Automatically recompile xmonad after every system update (`pacman -Syu`).

## Installation

```bash
cd ~/.config/install_scripts
./xmonad_pacman_hook.sh
```

## How it works

The hook runs as root after every pacman transaction (install or upgrade of any package).
It uses `su - lautarob` to run `xmonad --recompile` as your user, ensuring proper permissions
for `~/.config/xmonad/`.

## Files created

- `/etc/pacman.d/hooks/xmonad-recompile.hook`

## Removal

```bash
sudo rm /etc/pacman.d/hooks/xmonad-recompile.hook
```

## Customization

To trigger only on specific packages (e.g., xmonad only), change the `Target` field:

```ini
Target = xmonad
```

Or match multiple packages:

```ini
Target = xmonad
Target = xmonad-contrib
```