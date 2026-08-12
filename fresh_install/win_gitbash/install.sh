#!/bin/bash
# install.sh - Sets up Windows Git Bash dotfiles

set -e

# Find the absolute path of the directory this script is in
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

echo "=================================================="
echo "   Installing Git Bash Configuration Files        "
echo "=================================================="

# Map of source names (in repo) to target names (in HOME)
declare -A dotfiles=(
  ["bashrc"]=".bashrc"
  ["bash_aliases"]=".bash_aliases"
  ["bash_profile"]=".bash_profile"
  ["inputrc"]=".inputrc"
  ["vimrc"]=".vimrc"
  ["minttyrc"]=".minttyrc"
  ["starship.toml"]=".config/starship.toml"
)

# Backup and link
for source in "${!dotfiles[@]}"; do
  target_file="$HOME/${dotfiles[$source]}"
  source_file="$SCRIPT_DIR/$source"

  if [ -f "$source_file" ]; then
    # Ensure parent directory of target exists (e.g. for .config/starship.toml)
    mkdir -p "$(dirname "$target_file")"

    # If target already exists and is not a symbolic link, back it up
    if [ -f "$target_file" ] && [ ! -L "$target_file" ]; then
      echo "-> Backing up existing $target_file to ${target_file}.bak"
      mv "$target_file" "${target_file}.bak"
    fi

    # Create the link/copy
    echo "-> Linking $target_file -> $source_file"
    ln -sf "$source_file" "$target_file"
  else
    echo "-> Warning: Source file $source_file does not exist, skipping."
  fi
done

# --- Install Windows Packages via WinGet ---
if command -v winget.exe &> /dev/null; then
  echo "=================================================="
  echo "   Checking and Installing Windows CLI Packages   "
  echo "=================================================="
  
  # Map command name to winget package ID
  declare -A cli_packages=(
    ["btop"]="aristocratos.btop4win"
    ["yazi"]="sxyazi.yazi"
    ["starship"]="Starship.Starship"
    ["eza"]="eza-community.eza"
    ["zoxide"]="ajeetdsouza.zoxide"
    ["fzf"]="junegunn.fzf"
  )

  for cmd in "${!cli_packages[@]}"; do
    # Check if the command is already available
    if ! command -v "$cmd" &> /dev/null && ! command -v "${cmd}.exe" &> /dev/null; then
      echo "-> $cmd is not installed. Installing via WinGet..."
      winget.exe install --id "${cli_packages[$cmd]}" --silent --accept-source-agreements --accept-package-agreements || echo "Failed to install $cmd"
    else
      echo "-> $cmd is already installed."
    fi
  done
else
  echo "=================================================="
  echo "-> WinGet is not available. Skipping automatic tool installation."
fi

echo "=================================================="
echo " Setup complete! Please restart Git Bash.        "
echo " Note: In Git Bash on Windows, 'ln -sf' might     "
echo " perform a file copy instead of a live symlink    "
echo " depending on your system configuration. If you   "
echo " make updates to the files in this repo, run      "
echo " './install.sh' again to apply the changes to your "
echo " home directory.                                  "
echo "=================================================="
