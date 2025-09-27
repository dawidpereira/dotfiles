#!/bin/bash

# Setup script for Hyprland input configuration
# This script handles symlinking with backup of existing files

DOTFILES_DIR="$HOME/Repositories/dotfiles"
HYPR_CONFIG_DIR="$HOME/.config/hypr"
INPUT_CONF="input.conf"
BACKUP_SUFFIX=".backup-$(date +%Y%m%d-%H%M%S)"

echo "Setting up Hyprland input configuration for Magic Trackpad..."

# Ensure the Hypr config directory exists
mkdir -p "$HYPR_CONFIG_DIR"

# Check if input.conf already exists in the config directory
if [ -e "$HYPR_CONFIG_DIR/$INPUT_CONF" ]; then
    # Check if it's already a symlink
    if [ -L "$HYPR_CONFIG_DIR/$INPUT_CONF" ]; then
        # Check if it points to our dotfiles
        CURRENT_TARGET=$(readlink "$HYPR_CONFIG_DIR/$INPUT_CONF")
        if [ "$CURRENT_TARGET" = "$DOTFILES_DIR/hypr/$INPUT_CONF" ]; then
            echo "✓ input.conf is already correctly symlinked"
        else
            echo "⚠ input.conf is symlinked to a different location: $CURRENT_TARGET"
            echo "  Removing old symlink..."
            rm "$HYPR_CONFIG_DIR/$INPUT_CONF"
        fi
    else
        # It's a regular file, back it up
        echo "⚠ Found existing input.conf (not a symlink)"
        echo "  Creating backup: $INPUT_CONF$BACKUP_SUFFIX"
        mv "$HYPR_CONFIG_DIR/$INPUT_CONF" "$HYPR_CONFIG_DIR/$INPUT_CONF$BACKUP_SUFFIX"
    fi
fi

# Create the symlink if it doesn't exist
if [ ! -L "$HYPR_CONFIG_DIR/$INPUT_CONF" ]; then
    echo "Creating symlink..."
    ln -sf "$DOTFILES_DIR/hypr/$INPUT_CONF" "$HYPR_CONFIG_DIR/$INPUT_CONF"
fi

# Verify the symlink was created successfully
if [ -L "$HYPR_CONFIG_DIR/$INPUT_CONF" ]; then
    echo "✓ Successfully configured input settings:"
    echo "  $HYPR_CONFIG_DIR/$INPUT_CONF -> $DOTFILES_DIR/hypr/$INPUT_CONF"
    echo ""
    echo "Magic Trackpad features enabled:"
    echo "  • Scroll speed reduced to 50% (adjustable via scroll_factor)"
    echo "  • Natural scrolling (macOS-style)"
    echo "  • Tap to click"
    echo "  • Two-finger right-click"
    echo "  • Three-finger workspace swipe"
    echo ""
    echo "Available gestures:"
    echo "  • 3-finger swipe left/right: Switch workspaces"
    echo "  • 2-finger scroll: Scroll content (reduced speed)"
    echo "  • 2-finger tap: Right-click"
    echo "  • 3-finger tap: Middle-click"
    echo ""
    echo "To adjust scroll speed, edit scroll_factor in input.conf:"
    echo "  0.1 = very slow, 0.5 = half speed, 1.0 = normal, 2.0 = double speed"
    echo ""
    echo "⚠ Reload Hyprland (Super+Shift+E) or restart to apply changes"
else
    echo "✗ Failed to create symlink"
    exit 1
fi