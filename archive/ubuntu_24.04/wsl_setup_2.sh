#!/bin/bash
set -e

# --- System Updates and Basic Tools ---
echo "--- Updating system and installing essential packages ---"
sudo apt update && sudo apt upgrade -y
sudo apt install -y \
  asciinema \
  curl \
  git \
  htop \
  httpie \
  nmap \
  ranger \
  tldr \
  tmux \
  tree \
  trash-cli \
  unrar \
  wget \
  bat \
  duf \
  zoxide \
  jq \
  fd-find \
  neovim \
  eza \
  ripgrep \
  fzf \
  bat

# --- Node.js with nvm ---
if [ !  -d "$HOME/.nvm" ]; then
  echo "--- Installing nvm ---"
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
fi

# Persist nvm setup in .bashrc
if ! grep -q 'NVM_DIR' ~/.bashrc; then
  cat <<'EOF' >> ~/.bashrc

# NVM setup
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
EOF
fi

# Load nvm into current shell
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

if ! nvm ls | grep -q 'lts'; then
  echo "--- Installing Node.js LTS via nvm ---"
  nvm install --lts
  nvm alias default lts/*
fi

# --- Python with pyenv ---
sudo apt install -y make build-essential libssl-dev zlib1g-dev \
  libbz2-dev libreadline-dev libsqlite3-dev llvm \
  libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev

if [ ! -d "$HOME/.pyenv" ]; then
  echo "--- Installing pyenv ---"
  curl https://pyenv.run | bash
fi

# Persist pyenv setup in .bashrc
if ! grep -q 'pyenv init' ~/.bashrc; then
  cat <<'EOF' >> ~/.bashrc

# Pyenv setup
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
EOF
fi

# Load pyenv into current shell
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

if ! pyenv versions --bare | grep -q '^3.12'; then
  echo "--- Installing Python 3.12 via pyenv ---"
  pyenv install -s 3.12
  pyenv global 3.12
fi

# --- Final Cleanup ---
sudo apt autoremove -y
sudo apt autoclean -y
sudo apt clean

echo "--- Setup complete! ---"
echo "👉 Restart your shell or run: source ~/.bashrc"
