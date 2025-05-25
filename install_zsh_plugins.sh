if [[ -f $HOME/.local/bin/zpm ]]; then
  zpm install jeffreytse/zsh-vi-mode
  zpm install zsh-users/zsh-syntax-highlighting
  zpm install zsh-users/zsh-autosuggestions
else
  echo -e "Z Package Manager is not installed.\n Make sure you added ~/.local/bin to the PATH variable"
fi
