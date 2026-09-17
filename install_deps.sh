#!/usr/bin/env sh
# OS-aware dependency installer.
DIR="$(cd "$(dirname "$0")" && pwd)"

case "$(uname -s)" in
    Darwin)
        if ! command -v brew >/dev/null 2>&1; then
            echo "Homebrew not found. Install it from https://brew.sh first."
            exit 1
        fi
        echo "Installing macOS dependencies via Brewfile..."
        brew bundle --file="$DIR/Brewfile"
        ;;
    Linux)
        echo "Installing Linux dependencies via pacman..."
        sudo pacman -S --needed fzf fd ripgrep neovim tmux $(cat "$DIR/packages" 2>/dev/null)
        ;;
    *)
        echo "Unsupported OS: $(uname -s)"
        exit 1
        ;;
esac
