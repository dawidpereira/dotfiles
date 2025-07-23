#!/bin/bash
# Script to build symlinks using GNU Stow
# and to create additional symlinks for special packages

# First, run stow (which reads your .stowrc and uses --target=~/.config)
stow .

# Define paths for nushell
SOURCE_NUSHELL="$(pwd)/nushell"                            # Path to the "nushell" package in your repo
TARGET_NUSHELL="$HOME/Library/Application Support/nushell" # Additional target location

# Remove existing nushell target if present
if [ -e "$TARGET_NUSHELL" ]; then
  echo "Target '$TARGET_NUSHELL' already exists – removing..."
  rm -rf "$TARGET_NUSHELL"
fi

# Create the additional nushell symlink
ln -s "$SOURCE_NUSHELL" "$TARGET_NUSHELL"

echo "Additional symlink for 'nushell' created:"
echo "  $TARGET_NUSHELL -> $SOURCE_NUSHELL"

# Define paths for Claude Code configuration
SOURCE_CLAUDE="$(pwd)/claude" # Path to the "claude" package in your repo
TARGET_CLAUDE="$HOME/.claude" # Claude Code config directory

# Create ~/.claude directory if it doesn't exist
if [ ! -d "$TARGET_CLAUDE" ]; then
  echo "Creating Claude Code config directory..."
  mkdir -p "$TARGET_CLAUDE"
fi

# Remove existing Claude config files if they're regular files (not symlinks)
for config_file in "settings.json" "CLAUDE.md"; do
  target_file="$TARGET_CLAUDE/$config_file"
  if [ -f "$target_file" ] && [ ! -L "$target_file" ]; then
    echo "Backing up existing $config_file to ${config_file}.backup"
    mv "$target_file" "${target_file}.backup"
  elif [ -L "$target_file" ]; then
    echo "Removing existing symlink for $config_file"
    rm "$target_file"
  fi
done

# Create symlinks for Claude Code configuration files
ln -s "$SOURCE_CLAUDE/settings.json" "$TARGET_CLAUDE/settings.json"
ln -s "$SOURCE_CLAUDE/CLAUDE.md" "$TARGET_CLAUDE/CLAUDE.md"

# Create symlink for commands directory
if [ -d "$TARGET_CLAUDE/commands" ] && [ ! -L "$TARGET_CLAUDE/commands" ]; then
  echo "Backing up existing commands directory to commands.backup"
  mv "$TARGET_CLAUDE/commands" "$TARGET_CLAUDE/commands.backup"
elif [ -L "$TARGET_CLAUDE/commands" ]; then
  echo "Removing existing commands symlink"
  rm "$TARGET_CLAUDE/commands"
fi
ln -s "$SOURCE_CLAUDE/commands" "$TARGET_CLAUDE/commands"

echo "Claude Code configuration symlinks created:"
echo "  $TARGET_CLAUDE/settings.json -> $SOURCE_CLAUDE/settings.json"
echo "  $TARGET_CLAUDE/CLAUDE.md -> $SOURCE_CLAUDE/CLAUDE.md"
echo "  $TARGET_CLAUDE/commands -> $SOURCE_CLAUDE/commands"

# Note: hooks directory is referenced directly from dotfiles location in settings.json
echo "Note: Hook scripts are referenced directly from $SOURCE_CLAUDE/hooks in settings.json"
