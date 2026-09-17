#!/usr/bin/env zsh

# Powerlevel10k theme (set as ZSH_THEME in .zshrc)
P10K_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
if [[ ! -d $P10K_DIR ]]; then
  echo "Installing powerlevel10k theme..."
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$P10K_DIR"
else
  echo "powerlevel10k already installed."
fi

# zsh plugins via zpm
if [[ -f $HOME/.local/bin/zpm ]]; then
  zpm install jeffreytse/zsh-vi-mode
  zpm install zsh-users/zsh-syntax-highlighting
  zpm install zsh-users/zsh-autosuggestions
else
  echo -e "Z Package Manager is not installed.\n Make sure you added ~/.local/bin to the PATH variable"
fi
