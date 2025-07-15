#!/bin/zsh

# The directory where your actual dotfiles are stored
# Assuming new_dotfiles is directly in your home directory
DOTFILES_DIR="$HOME/.dotfiles"

# --- Configuration: Maps dotfile names in your repo to their target locations ---
# Format: "dotfile_in_repo:target_path_from_home"
# For nvim, the target is ~/.config/nvim, so we handle it slightly differently
# by specifying the full target path.

declare -A DOTFILE_MAP
DOTFILE_MAP=(
    ["nvim"]="$HOME/.config/nvim"  # nvim config directory
    [".emacs.d"]="$HOME/.emacs.d"
    ["doom"]="$HOME/.config/doom"
    [".tmux.conf"]="$HOME/.tmux.conf"
    [".zshrc"]="$HOME/.zshrc"
    [".vimrc"]="$HOME/.vimrc"
    [".i3"]="$HOME/.i3"
    ["scripts/zpm"]="$HOME/.local/bin/zpm"
    ["scripts/tmux-sessionizer"]="$HOME/.local/bin/tmux-sessionizer"
    ["fonts/FiraCodeNerdFont"]="$HOME/.local/share/fonts/FiraCodeNerdFont"
    [".gitconfig"]="$HOME/.gitconfig"
    [".oh-my-zsh"]="$HOME/.oh-my-zsh"
    [".p10k.zsh"]="$HOME/.p10k.zsh"
    # Add more files here as needed, e.g.:
    # ["my_scripts/cool_script.sh"]="$HOME/.local/bin/cool_script.sh" # Example for a script
)

# --- End Configuration ---

echo "Starting dotfile symlinking process..."
echo "Dotfiles source directory: $DOTFILES_DIR"
echo "----------------------------------------"

# Ensure the main dotfiles directory exists
if [ ! -d "$DOTFILES_DIR" ]; then
    echo "ERROR: Dotfiles source directory not found: $DOTFILES_DIR"
    exit 1
fi

# Loop through the map and create symlinks
for df_in_repo in "${(k)DOTFILE_MAP[@]}"; do
    source_path="$DOTFILES_DIR/$df_in_repo"
    target_path="${DOTFILE_MAP[$df_in_repo]}"
    target_dir=$(dirname "$target_path")

    echo "Processing: $df_in_repo"
    echo "  Source: $source_path"
    echo "  Target: $target_path"

    # Check if the source file/directory actually exists in your dotfiles repo
    if [ ! -e "$source_path" ]; then
        echo "  WARNING: Source file/directory not found: $source_path. Skipping."
        echo "----------------------------------------"
        continue
    fi

    # Create target directory if it doesn't exist (e.g., ~/.config)
    if [ ! -d "$target_dir" ]; then
        echo "  Creating parent directory: $target_dir"
        mkdir -p "$target_dir"
        if [ $? -ne 0 ]; then
            echo "  ERROR: Failed to create parent directory $target_dir. Skipping."
            echo "----------------------------------------"
            continue
        fi
    fi

    # If the target already exists, back it up
    if [ -L "$target_path" ]; then # If it's already a symlink
        echo "  Symlink already exists at $target_path."
        # Optional: remove and relink if you want to ensure it points to the correct source
        # current_link_target=$(readlink "$target_path")
        # if [ "$current_link_target" == "$source_path" ]; then
        #     echo "  It already points to the correct source. Skipping relink."
        # else
        #     echo "  It points to a different source ($current_link_target). Removing and relinking."
        #     rm "$target_path"
        # fi
        # For simplicity, we'll just assume if it's a link, it might be an old one we want to replace or it's correct.
        # If you want to be more robust, uncomment and adapt the check above.
        # For now, if it's a symlink, we'll remove it to create a fresh one.
        echo "  Removing existing symlink at $target_path."
        rm "$target_path"

    elif [ -e "$target_path" ]; then # If it's a regular file or directory
        backup_path="$target_path.bak.$(date +%Y%m%d%H%M%S)"
        echo "  Backing up existing $target_path to $backup_path"
        mv "$target_path" "$backup_path"
        if [ $? -ne 0 ]; then
            echo "  ERROR: Failed to back up $target_path. Skipping."
            echo "----------------------------------------"
            continue
        fi
    fi

    # Create the symlink
    echo "  Creating symlink: $target_path -> $source_path"
    ln -sfn "$source_path" "$target_path"
    if [ $? -eq 0 ]; then
        echo "  Successfully created symlink."
    else
        echo "  ERROR: Failed to create symlink for $target_path."
    fi
    echo "----------------------------------------"
done

echo "Dotfile symlinking process complete."
echo "Updating font cache."
fc-cache -fv
echo "Font cache updated."

