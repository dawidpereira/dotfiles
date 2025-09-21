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

# Check for existing claude-code configuration
if [ -L ~/.config/claude-code ] || [ -d ~/.config/claude-code ]; then
  echo -e "${YELLOW}Existing claude-code configuration detected, checking if it's managed by stow...${NC}"

  # Check if the symlinks point to our dotfiles
  if [ -L ~/.config/claude-code/settings.json ] && [ "$(readlink ~/.config/claude-code/settings.json)" = "$SCRIPT_DIR/claude-code/settings.json" ]; then
    echo -e "${GREEN}✓ claude-code already properly configured${NC}"
  else
    echo -e "${YELLOW}Warning: claude-code configuration exists but not managed by this dotfiles setup${NC}"
    echo -e "${YELLOW}Skipping claude-code in stow to avoid conflicts${NC}"
    # Run stow with ignore for claude-code
    stow -v --ignore='claude-code' .
  fi
else
  # No existing configuration, safe to stow everything
  stow -v .
fi

# Ensure claude-code is properly linked even if stow skipped it
if [ ! -L ~/.config/claude-code/settings.json ] || [ "$(readlink ~/.config/claude-code/settings.json)" != "$SCRIPT_DIR/claude-code/settings.json" ]; then
  echo -e "${YELLOW}Setting up Claude Code configuration manually...${NC}"
  mkdir -p ~/.config/claude-code
  ln -sf "$SCRIPT_DIR/claude-code/settings.json" ~/.config/claude-code/settings.json
  ln -sf "$SCRIPT_DIR/claude-code/hooks" ~/.config/claude-code/hooks
  echo -e "${GREEN}✓ Claude Code configuration linked${NC}"
fi

# Special handling for starship.toml (Omarchy creates it by default)
echo -e "${YELLOW}Setting up starship configuration...${NC}"

# Always backup the existing starship.toml (whether it's Omarchy's default or custom)
if [ -f ~/.config/starship.toml ]; then
  # Only backup if it's not already our symlink
  if [ ! -L ~/.config/starship.toml ] || [ "$(readlink ~/.config/starship.toml)" != "$SCRIPT_DIR/starship.toml" ]; then
    echo -e "${YELLOW}Backing up existing starship.toml...${NC}"
    mv ~/.config/starship.toml ~/.config/starship.toml.omarchy-backup
  fi
fi

# Remove the symlink to the folder if it exists (from stow)
if [ -L ~/.config/starship ]; then
  rm ~/.config/starship
fi

# Create direct symlink to our custom starship.toml
ln -sf "$SCRIPT_DIR/starship.toml" ~/.config/starship.toml
echo -e "${GREEN}✓ Starship configuration linked${NC}"
echo -e "${YELLOW}  Original Omarchy config backed up to ~/.config/starship.toml.omarchy-backup${NC}"


echo -e "${GREEN}✓ Configuration files linked successfully${NC}"

# Set up bash configuration
echo -e "${YELLOW}Setting up bash configuration...${NC}"
if ! grep -q "source ~/.config/bash/bashrc" ~/.bashrc 2>/dev/null; then
  echo "" >> ~/.bashrc
  echo "# Source custom bash configuration" >> ~/.bashrc
  echo "[ -f ~/.config/bash/bashrc ] && source ~/.config/bash/bashrc" >> ~/.bashrc
  echo -e "${GREEN}✓ Bash configuration added to ~/.bashrc${NC}"
else
  echo -e "${GREEN}✓ Bash configuration already sourced in ~/.bashrc${NC}"
fi


# Set up 1Password XWayland fix
echo -e "${YELLOW}Setting up 1Password XWayland fix...${NC}"
if [ -f "$SCRIPT_DIR/1password/setup.sh" ]; then
  "$SCRIPT_DIR/1password/setup.sh"
else
  echo -e "${YELLOW}1Password setup script not found${NC}"
fi

# Set up Hypr bindings
echo -e "${YELLOW}Setting up Hypr bindings...${NC}"
if [ -f "$SCRIPT_DIR/hypr/bindings.conf" ]; then
  mkdir -p ~/.config/hypr
  ln -sf "$SCRIPT_DIR/hypr/bindings.conf" ~/.config/hypr/bindings.conf
  echo -e "${GREEN}✓ Hypr bindings configured${NC}"
else
  echo -e "${YELLOW}Hypr bindings file not found${NC}"
fi

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
echo -e "${YELLOW}Optional Configurations:${NC}"
echo ""
echo "• 1Password XWayland Fix (for Wayland/Hyprland):"
echo "  ${GREEN}./1password/setup.sh${NC}"
echo "  Fixes authentication prompts by forcing X11 mode"
echo ""
echo "• Git Commit Signing with 1Password SSH:"
echo "  ${GREEN}./setup-git-signing.sh${NC}"
echo "  Configure git to sign commits using 1Password SSH agent"
echo ""
echo -e "${GREEN}Enjoy your Omarchy setup!${NC}"