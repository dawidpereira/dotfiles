#!/bin/bash

# Minimal 1Password XWayland Setup
# Fixes authentication prompts on Wayland/Hyprland

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${GREEN}1Password XWayland Fix${NC}"
echo ""

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Install wrapper
echo -e "${YELLOW}Installing XWayland wrapper...${NC}"
mkdir -p ~/.local/bin
cp "$SCRIPT_DIR/1password-xwayland" ~/.local/bin/
chmod +x ~/.local/bin/1password-xwayland

# Add alias to bashrc
BASHRC="$HOME/.config/bash/bashrc"
if [ -f "$BASHRC" ]; then
    if ! grep -q "alias 1password=" "$BASHRC"; then
        echo "" >> "$BASHRC"
        echo "# 1Password XWayland fix" >> "$BASHRC"
        echo "alias 1password='1password-xwayland'" >> "$BASHRC"
        echo -e "${GREEN}✓ Added alias to bashrc${NC}"
    else
        echo -e "${GREEN}✓ Alias already exists${NC}"
    fi
fi

echo ""
echo -e "${GREEN}Setup complete!${NC}"
echo ""
echo "To use: Run '1password' or '1password-xwayland'"
echo "This forces 1Password to use X11 mode, fixing authentication prompts."