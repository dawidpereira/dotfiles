#!/bin/bash
# Script to build symlinks using GNU Stow
# and to create additional symlinks for special packages

# Ensure we're running from the dotfiles directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [[ "$(pwd)" != "$SCRIPT_DIR" ]]; then
  echo "Error: This script must be run from the dotfiles directory"
  echo "Current directory: $(pwd)"
  echo "Expected directory: $SCRIPT_DIR"
  exit 1
fi

# First, run stow (which reads your .stowrc and uses --target=~/.config)
stow .

# Ensure all hook scripts are executable before creating symlinks
SOURCE_CLAUDE="$(pwd)/claude"
if [ -d "$SOURCE_CLAUDE/hooks" ]; then
  echo "Setting executable permissions on hook scripts..."
  chmod +x "$SOURCE_CLAUDE/hooks"/*.sh
  echo "✅ Hook scripts are now executable"
else
  echo "⚠️  Warning: hooks directory not found at $SOURCE_CLAUDE/hooks"
fi

# Define paths for nushell
SOURCE_NUSHELL="$(pwd)/nushell"                            # Path to the "nushell" package in your repo
TARGET_NUSHELL="$HOME/Library/Application Support/nushell" # Additional target location

# Remove existing nushell target if present
if [ -L "$TARGET_NUSHELL" ]; then
  echo "Target '$TARGET_NUSHELL' is a symlink – removing..."
  rm "$TARGET_NUSHELL"
elif [ -d "$TARGET_NUSHELL" ]; then
  echo "Target '$TARGET_NUSHELL' is a directory – backing up..."
  backup_name="${TARGET_NUSHELL}.backup.$(date +%s)"
  mv "$TARGET_NUSHELL" "$backup_name"
  echo "Backed up to: $backup_name"
elif [ -e "$TARGET_NUSHELL" ]; then
  echo "Target '$TARGET_NUSHELL' exists but is not a directory or symlink – backing up..."
  backup_name="${TARGET_NUSHELL}.backup.$(date +%s)"
  mv "$TARGET_NUSHELL" "$backup_name"
  echo "Backed up to: $backup_name"
fi

# Create the additional nushell symlink
ln -s "$SOURCE_NUSHELL" "$TARGET_NUSHELL"

echo "Additional symlink for 'nushell' created:"
echo "  $TARGET_NUSHELL -> $SOURCE_NUSHELL"

# Define paths for Claude Code configuration
# SOURCE_CLAUDE already defined above
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
