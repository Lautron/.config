export EDITOR="nvim"
export VISUAL="nvim"
export BROWSER="zen-browser"
export SUDO_ASKPASS="$HOME/.config/scripts/dmenupass"

path=(
  "$HOME/.local/bin"
  "$HOME/.config/scripts"
  $path
)
typeset -U path PATH

# Load environment variables from a .env file
lenv() {
  local env_file="${1:-.env}"

  if [ ! -f "$env_file" ]; then
    echo "load_env: file not found: $env_file"
    return 1
  fi

  set -a
  source "$env_file"
  set +a
  echo "Loaded env vars from: $env_file"
}
