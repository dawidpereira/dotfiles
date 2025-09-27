#!/bin/bash

# Setup script for Hyprland monitors configuration
# This script handles symlinking with backup of existing files

DOTFILES_DIR="$HOME/Repositories/dotfiles"
HYPR_CONFIG_DIR="$HOME/.config/hypr"
MONITORS_CONF="monitors.conf"
BACKUP_SUFFIX=".backup-$(date +%Y%m%d-%H%M%S)"

echo "Setting up Hyprland monitors configuration..."

# Ensure the Hypr config directory exists
mkdir -p "$HYPR_CONFIG_DIR"

# Check if monitors.conf already exists in the config directory
if [ -e "$HYPR_CONFIG_DIR/$MONITORS_CONF" ]; then
    # Check if it's already a symlink
    if [ -L "$HYPR_CONFIG_DIR/$MONITORS_CONF" ]; then
        # Check if it points to our dotfiles
        CURRENT_TARGET=$(readlink "$HYPR_CONFIG_DIR/$MONITORS_CONF")
        if [ "$CURRENT_TARGET" = "$DOTFILES_DIR/hypr/$MONITORS_CONF" ]; then
            echo "✓ monitors.conf is already correctly symlinked"
            exit 0
        else
            echo "⚠ monitors.conf is symlinked to a different location: $CURRENT_TARGET"
            echo "  Removing old symlink..."
            rm "$HYPR_CONFIG_DIR/$MONITORS_CONF"
        fi
    else
        # It's a regular file, back it up
        echo "⚠ Found existing monitors.conf (not a symlink)"
        echo "  Creating backup: $MONITORS_CONF$BACKUP_SUFFIX"
        mv "$HYPR_CONFIG_DIR/$MONITORS_CONF" "$HYPR_CONFIG_DIR/$MONITORS_CONF$BACKUP_SUFFIX"
    fi
fi

# Create the symlink
echo "Creating symlink..."
ln -sf "$DOTFILES_DIR/hypr/$MONITORS_CONF" "$HYPR_CONFIG_DIR/$MONITORS_CONF"

# Verify the symlink was created successfully
if [ -L "$HYPR_CONFIG_DIR/$MONITORS_CONF" ]; then
    echo "✓ Successfully created symlink:"
    echo "  $HYPR_CONFIG_DIR/$MONITORS_CONF -> $DOTFILES_DIR/hypr/$MONITORS_CONF"
    echo ""
    echo "Monitor configuration:"
    echo "  • LG ULTRAGEAR+ 32\" 4K (HDMI-A-1): Scale 1.5, Position: top (0x0)"
    echo "  • ARZOPA 16\" 2K (DP-1): Scale 1.333333, Position: bottom-center (320x1440)"
    echo ""
    echo "⚠ Remember to relaunch Hyprland for changes to take effect (Super+Esc, then Relaunch)"
else
    echo "✗ Failed to create symlink"
    exit 1
fi