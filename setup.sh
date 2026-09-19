#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status
set -euo pipefail

# Get the directory of this script
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "========================================="
echo " Setting up Dotfiles from: $DOTFILES_DIR"
echo "========================================="

# Define the files/directories to symlink
# Format: "source_path_relative_to_repo:destination_path_relative_to_home"
LINKS=(
    ".config/i3:.config/i3"
    ".config/i3status:.config/i3status"
    # ".bashrc:.bashrc"
    # ".prettierrc:.prettierrc"
)

for entry in "${LINKS[@]}"; do
    # Split the entry into source and destination
    IFS=":" read -r src_rel dest_rel <<< "$entry"
    
    SRC="$DOTFILES_DIR/$src_rel"
    DEST="$HOME/$dest_rel"
    
    # Skip if the source file/directory does not exist in the repository
    if [ ! -e "$SRC" ]; then
        continue
    fi

    echo "Configuring: ~/$dest_rel"

    # Ensure parent directory of destination exists
    DEST_DIR=$(dirname "$DEST")
    mkdir -p "$DEST_DIR"

    if [ -L "$DEST" ]; then
        # It's a symlink. Check where it points.
        CURRENT_TARGET=$(readlink "$DEST")
        if [ "$CURRENT_TARGET" = "$SRC" ]; then
            echo "  ✔ Already linked correctly."
            continue
        else
            echo "  ⚠ Existing symlink points elsewhere: $CURRENT_TARGET"
            echo "    Backing up existing symlink to $DEST.backup..."
            mv "$DEST" "$DEST.backup"
        fi
    elif [ -e "$DEST" ]; then
        # It exists and is a regular file or directory
        echo "  ⚠ Found existing file/directory at $DEST."
        echo "    Backing up to $DEST.backup to prevent data loss..."
        mv "$DEST" "$DEST.backup"
    fi

    # Create the symlink
    ln -s "$SRC" "$DEST"
    echo "  ✔ Symlink created successfully!"
done

echo "========================================="
echo " Setup complete!"
echo "========================================="
