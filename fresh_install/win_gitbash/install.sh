#!/bin/bash
# install.sh - Sets up Windows Git Bash dotfiles

set -e

# Find the absolute path of the directory this script is in
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Capture existing git user configuration before we overwrite .gitconfig
EXISTING_NAME=$(git config --global user.name 2>/dev/null || echo "")
EXISTING_EMAIL=$(git config --global user.email 2>/dev/null || echo "")

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
  ["yazi.toml"]=".config/yazi/yazi.toml"
  ["gitconfig"]=".gitconfig"
  ["gitignore_global"]=".gitignore_global"
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

# Ensure local Vim colors directory exists and link colors from repo
if [ -d "$SCRIPT_DIR/colors" ]; then
  mkdir -p "$HOME/.vim/colors"
  for color_file in "$SCRIPT_DIR/colors"/*; do
    if [ -f "$color_file" ]; then
      color_name=$(basename "$color_file")
      echo "-> Linking $HOME/.vim/colors/$color_name -> $color_file"
      ln -sf "$color_file" "$HOME/.vim/colors/$color_name"
    fi
  done
fi


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
    ["bat"]="sharkdp.bat"
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

# --- Configure Local/Private Git Settings ---
echo "=================================================="
echo "   Configuring Local Git User Settings            "
echo "=================================================="
LOCAL_GITCONFIG="$HOME/.gitconfig_local"

# If ~/.gitconfig_local doesn't exist, we will create it and write the settings
if [ ! -f "$LOCAL_GITCONFIG" ]; then
  touch "$LOCAL_GITCONFIG"
  
  # Resolve Git Username
  if [ -n "$EXISTING_NAME" ]; then
    echo "-> Migrated existing Git user.name: $EXISTING_NAME"
    git config --file "$LOCAL_GITCONFIG" user.name "$EXISTING_NAME"
  else
    read -p "Enter your Git username (e.g., '12q1'): " git_name
    git config --file "$LOCAL_GITCONFIG" user.name "$git_name"
  fi

  # Resolve Git Email
  if [ -n "$EXISTING_EMAIL" ]; then
    echo "-> Migrated existing Git user.email: $EXISTING_EMAIL"
    git config --file "$LOCAL_GITCONFIG" user.email "$EXISTING_EMAIL"
  else
    read -p "Enter your Git email: " git_email
    git config --file "$LOCAL_GITCONFIG" user.email "$git_email"
  fi
else
  echo "-> Private ~/.gitconfig_local already exists. Skipping recreation."
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
