#!/bin/zsh
# Cross-platform dotfile symlinker.
# Layout:
#   common/  -> linked on every machine
#   linux/   -> linked only on Linux
#   macos/   -> linked only on macOS
# The .oh-my-zsh submodule lives at the repo root (vendored dependency).

DOTFILES_DIR="${0:A:h}"   # directory this script lives in

# --- Detect OS ---
case "$(uname -s)" in
    Darwin) OS="macos" ;;
    Linux)  OS="linux" ;;
    *)      echo "Unsupported OS: $(uname -s)"; exit 1 ;;
esac
echo "Detected OS: $OS"

# --- Symlink maps: "source_relative_to_repo:target_absolute_path" ---
# Common (all machines)
COMMON_MAP=(
    "common/.zshrc:$HOME/.zshrc"
    "common/.vimrc:$HOME/.vimrc"
    "common/.tmux.conf:$HOME/.tmux.conf"
    "common/.gitconfig:$HOME/.gitconfig"
    "common/.p10k.zsh:$HOME/.p10k.zsh"
    "common/nvim:$HOME/.config/nvim"
    "common/doom:$HOME/.config/doom"
    "common/scripts/zpm:$HOME/.local/bin/zpm"
    "common/scripts/tmux-sessionizer:$HOME/.local/bin/tmux-sessionizer"
    ".oh-my-zsh:$HOME/.oh-my-zsh"
)

# macOS-only
MACOS_MAP=(
    "macos/aerospace:$HOME/.config/aerospace"
    # Fonts on macOS are installed via Homebrew (see Brewfile), not symlinked.
)

# Linux-only
LINUX_MAP=(
    "linux/.i3:$HOME/.i3"
    "common/fonts/FiraCodeNerdFont:$HOME/.local/share/fonts/FiraCodeNerdFont"
)

# Build the active map = common + OS-specific
MAP=("${COMMON_MAP[@]}")
if [ "$OS" = "macos" ]; then
    MAP+=("${MACOS_MAP[@]}")
else
    MAP+=("${LINUX_MAP[@]}")
fi

echo "Dotfiles source directory: $DOTFILES_DIR"
echo "----------------------------------------"

if [ ! -d "$DOTFILES_DIR" ]; then
    echo "ERROR: Dotfiles source directory not found: $DOTFILES_DIR"
    exit 1
fi

for entry in "${MAP[@]}"; do
    df_in_repo="${entry%%:*}"
    target_path="${entry#*:}"
    source_path="$DOTFILES_DIR/$df_in_repo"
    target_dir=$(dirname "$target_path")

    echo "Processing: $df_in_repo -> $target_path"

    if [ ! -e "$source_path" ]; then
        echo "  WARNING: Source not found: $source_path. Skipping."
        echo "----------------------------------------"
        continue
    fi

    if [ ! -d "$target_dir" ]; then
        echo "  Creating parent directory: $target_dir"
        mkdir -p "$target_dir" || { echo "  ERROR: mkdir failed. Skipping."; continue; }
    fi

    if [ -L "$target_path" ]; then
        echo "  Removing existing symlink."
        rm "$target_path"
    elif [ -e "$target_path" ]; then
        backup_path="$target_path.bak.$(date +%Y%m%d%H%M%S)"
        echo "  Backing up existing $target_path -> $backup_path"
        mv "$target_path" "$backup_path" || { echo "  ERROR: backup failed. Skipping."; continue; }
    fi

    ln -sfn "$source_path" "$target_path" \
        && echo "  Linked." \
        || echo "  ERROR: failed to link $target_path"
    echo "----------------------------------------"
done

# --- Refresh font cache (Linux only; macOS registers fonts automatically) ---
if [ "$OS" = "linux" ] && command -v fc-cache >/dev/null 2>&1; then
    echo "Updating font cache..."
    fc-cache -fv
    echo "Font cache updated."
fi

echo "Dotfile symlinking process complete."
