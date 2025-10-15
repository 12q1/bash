#!/bin/bash
set -e

# --- User Input ---
echo "--- Initial Setup Configuration ---"
# Prompt for Git Username
read -p "Enter your Git username (e.g., '12q1'): " GIT_NAME
echo "Git Username set to: $GIT_NAME"

# Prompt for email
read -p "Enter your email address (for Git and SSH key comment): " GIT_EMAIL
echo "Email set to: $GIT_EMAIL"
echo ""

# --- System Updates and Essentials ---
echo "--- Updating system and installing essential packages ---"
sudo apt update && sudo apt upgrade -y

# Define a list of packages to ensure are installed
packages=(
  asciinema curl git htop httpie nmap ranger tldr tmux tree
  trash-cli unrar wget bat duf zoxide jq fd-find neovim eza
  ripgrep fzf make build-essential libssl-dev zlib1g-dev
  libbz2-dev libreadline-dev libsqlite3-dev llvm
  libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev
)

# Install only the packages that are not already installed
sudo apt install -y "${packages[@]}"

# --- Node.js with nvm ---
if [ ! -d "$HOME/.nvm" ]; then
  echo "--- Installing nvm ---"
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
fi

# Add nvm to the .bashrc if it's not already there
if ! grep -q 'NVM_DIR' ~/.bashrc; then
  cat <<'EOF' >> ~/.bashrc

# NVM setup
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
EOF
fi

# Source NVM for the current script session
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Install Node.js LTS if no LTS version is installed
if ! nvm ls | grep -q 'lts'; then
  echo "--- Installing Node.js LTS via nvm ---"
  nvm install --lts
  nvm alias default lts/*
fi

# --- Python with pyenv ---
if [ ! -d "$HOME/.pyenv" ]; then
  echo "--- Installing pyenv ---"
  curl https://pyenv.run | bash
fi

if ! grep -q 'pyenv init' ~/.bashrc; then
  cat <<'EOF' >> ~/.bashrc

# Pyenv setup
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
EOF
fi

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

if ! pyenv versions --bare | grep -q '^3.12'; then
  echo "--- Installing Python 3.12 via pyenv ---"
  pyenv install -s 3.12
  pyenv global 3.12
fi

# --- Git Configuration ---
echo "--- Setting Git configuration ---"
git config --global user.email "$GIT_EMAIL"
git config --global user.name "$GIT_NAME"
git config --global init.defaultBranch main

# --- Link alias + Starship config from repo ---
echo "--- Linking alias and starship files from repo ---"

# Find the absolute path of the directory this script is in
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

ln -sf "$SCRIPT_DIR/bash_aliases" ~/.bash_aliases
mkdir -p ~/.config
ln -sf "$SCRIPT_DIR/starship.toml" ~/.config/starship.toml

# --- Starship Prompt ---
if ! command -v starship >/dev/null 2>&1; then
  echo "--- Installing Starship ---"
  curl -sS https://starship.rs/install.sh | sh -s -- -y
fi

if ! grep -q 'starship init bash' ~/.bashrc; then
  cat <<'EOF' >> ~/.bashrc

# Starship prompt
eval "$(starship init bash)"
EOF
fi

# --- Bash Autocomplete Settings ---
if ! grep -q '# Autocomplete Settings' ~/.bashrc; then
  echo "--- Adding Bash autocomplete settings to .bashrc ---"
  cat <<'EOF' >> ~/.bashrc

# Autocomplete Settings
bind 'set completion-ignore-case on' # ignores case in autocomplete
bind 'set show-all-if-ambiguous on' # single tab for autocomplete
EOF
fi

# --- SSH Key Generation ---
if [ ! -f "$HOME/.ssh/id_ed25519" ]; then
  echo "--- Generating a new ED25519 SSH key ---"
  mkdir -p "$HOME/.ssh"
  # Generate the key non-interactively, using the provided email as a comment
  ssh-keygen -t ed25519 -N "" -C "$GIT_EMAIL" -f "$HOME/.ssh/id_ed25519"

  echo "--- SSH key generated successfully ---"
else
  echo "--- SSH key already exists, skipping generation ---"
fi

# --- Final Cleanup ---
sudo apt autoremove -y && sudo apt autoclean -y && sudo apt clean

# --- Final Output ---
echo ""
echo "❗ Your SSH public key (copy this to GitHub, GitLab, etc.):"
echo "----------------------------------------------------------------"
cat "$HOME/.ssh/id_ed25519.pub"
echo "----------------------------------------------------------------"
echo ""
echo "--- Setup complete! ✅ ---"
echo "❗ IMPORTANT: For the prompt to display correctly, ensure you have a Nerd Font set in your terminal."
echo "👉 Restart your shell or run: source ~/.bashrc"