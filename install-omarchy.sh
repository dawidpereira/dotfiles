#!/bin/bash

# Omarchy Dotfiles Installation Script
# This script sets up dotfiles for Omarchy Linux environment

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}=====================================${NC}"
echo -e "${GREEN}  Omarchy Dotfiles Installation${NC}"
echo -e "${GREEN}=====================================${NC}"

# Ensure we're running from the dotfiles directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [[ "$(pwd)" != "$SCRIPT_DIR" ]]; then
  echo -e "${YELLOW}Switching to dotfiles directory: $SCRIPT_DIR${NC}"
  cd "$SCRIPT_DIR"
fi

# Check if stow is installed
if ! command -v stow &> /dev/null; then
  echo -e "${RED}Error: GNU Stow is not installed${NC}"
  echo "Please install stow using: pacman -S stow"
  exit 1
fi

# Create necessary directories if they don't exist
echo -e "${YELLOW}Creating config directories...${NC}"
mkdir -p ~/.config

# Run stow to create symlinks
echo -e "${YELLOW}Creating symlinks with stow...${NC}"
stow -v .

echo -e "${GREEN}✓ Configuration files linked successfully${NC}"

# Check if Omarchy theme directory exists
if [ -d ~/.config/omarchy/current/theme ]; then
  echo -e "${GREEN}✓ Omarchy theme directory detected${NC}"
else
  echo -e "${YELLOW}Note: Omarchy theme directory not found${NC}"
  echo -e "${YELLOW}      Ghostty will use default settings until Omarchy themes are available${NC}"
fi

# Reload bash configuration if in bash
if [ -n "$BASH_VERSION" ]; then
  echo -e "${YELLOW}Reloading bash configuration...${NC}"
  source ~/.bashrc 2>/dev/null || true
fi

echo -e "${GREEN}=====================================${NC}"
echo -e "${GREEN}  Installation Complete!${NC}"
echo -e "${GREEN}=====================================${NC}"
echo ""
echo "Next steps:"
echo "1. Restart your terminal or source your shell configuration"
echo "2. Configure Hyprland keybindings in ~/.config/hypr/hyprland.conf"
echo "3. Use Omarchy's menu (Setup > Configs) to edit configurations"
echo ""
echo -e "${GREEN}Enjoy your Omarchy setup!${NC}"