#!/bin/bash
# Script to build symlinks using GNU Stow
# and to create an additional symlink for the "nushell" package

# First, run stow (which reads your .stowrc and uses --target=~/.config)
stow .

# Define paths
SOURCE="$(pwd)/nushell"                            # Path to the "nushell" package in your repo
TARGET="$HOME/Library/Application Support/nushell" # Additional target location

# Remove existing target if present
if [ -e "$TARGET" ]; then
  echo "Target '$TARGET' already exists – removing..."
  rm -rf "$TARGET"
fi

# Create the additional symlink
ln -s "$SOURCE" "$TARGET"

echo "Additional symlink for 'nushell' created:"
echo "  $TARGET -> $SOURCE"
