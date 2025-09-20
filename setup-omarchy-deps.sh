#!/bin/bash

# Omarchy Dependencies Setup Script
# Installs required packages for the dotfiles to work properly

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "${CYAN}=====================================${NC}"
echo -e "${CYAN}  Omarchy Dependencies Setup${NC}"
echo -e "${CYAN}=====================================${NC}"

# List of packages to install
packages=(
  # Terminal multiplexer
  "tmux"

  # Shell prompt
  "starship"

  # System monitor
  "btop"

  # File management tools
  "stow"
  "fd"
  "ripgrep"
  "fzf"

  # Development tools
  "git"
  "lazygit"
  "nodejs"
  "npm"

  # Additional utilities
  "zoxide"
  "eza"
  "bat"
)

echo -e "${YELLOW}The following packages will be installed:${NC}"
echo "${packages[@]}" | tr ' ' '\n' | sed 's/^/  - /'

echo ""
read -p "Do you want to install these packages? (y/n): " confirm

if [ "$confirm" != "y" ] && [ "$confirm" != "Y" ]; then
  echo -e "${YELLOW}Installation cancelled.${NC}"
  exit 0
fi

echo -e "${YELLOW}Installing packages...${NC}"

# Update package database first
sudo pacman -Sy

# Install packages
for package in "${packages[@]}"; do
  if pacman -Qi "$package" &> /dev/null; then
    echo -e "${GREEN}✓${NC} $package is already installed"
  else
    echo -e "${YELLOW}Installing $package...${NC}"
    sudo pacman -S --noconfirm "$package"
    if [ $? -eq 0 ]; then
      echo -e "${GREEN}✓${NC} $package installed successfully"
    else
      echo -e "${RED}✗${NC} Failed to install $package"
    fi
  fi
done

echo -e "${GREEN}=====================================${NC}"
echo -e "${GREEN}  Setup Complete!${NC}"
echo -e "${GREEN}=====================================${NC}"

# Check tmux installation
if command -v tmux &> /dev/null; then
  echo -e "${GREEN}✓ Tmux is ready to use${NC}"
  echo "  Start tmux with: tmux"
  echo "  Your config is at: ~/.config/tmux/tmux.conf"
else
  echo -e "${RED}✗ Tmux installation failed${NC}"
fi

# Check starship installation
if command -v starship &> /dev/null; then
  echo -e "${GREEN}✓ Starship is ready${NC}"
  echo "  Add to your ~/.bashrc: eval \"\$(starship init bash)\""
else
  echo -e "${RED}✗ Starship installation failed${NC}"
fi

echo ""
echo "Next steps:"
echo "1. Run ./install-omarchy.sh to link your dotfiles"
echo "2. Restart your terminal"
echo "3. Start tmux to use your multiplexer setup"