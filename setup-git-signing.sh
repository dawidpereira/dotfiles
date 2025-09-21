#!/bin/bash

# Setup Git Commit Signing with 1Password
# This script configures git to use 1Password SSH agent for commit signing

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}=====================================${NC}"
echo -e "${GREEN}  Git Signing with 1Password Setup${NC}"
echo -e "${GREEN}=====================================${NC}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Check if 1Password CLI is installed
if ! command -v op &> /dev/null; then
    echo -e "${RED}Error: 1Password CLI (op) is not installed${NC}"
    echo "Please install it from: https://developer.1password.com/docs/cli/get-started"
    exit 1
fi

# Check if 1Password signing binary exists
if [ ! -f "/opt/1Password/op-ssh-sign" ]; then
    echo -e "${RED}Error: 1Password SSH signing binary not found${NC}"
    echo "Please ensure 1Password desktop app is installed"
    exit 1
fi

# Setup SSH config for 1Password agent
echo -e "${YELLOW}Setting up SSH configuration...${NC}"
mkdir -p ~/.ssh
chmod 700 ~/.ssh

# Check if SSH config exists and needs updating
if [ -f ~/.ssh/config ]; then
    # Check if 1Password agent is already configured
    if grep -q "IdentityAgent.*1password/agent.sock" ~/.ssh/config; then
        echo -e "${GREEN}✓ SSH already configured for 1Password agent${NC}"
    else
        echo -e "${YELLOW}Backing up existing SSH config...${NC}"
        cp ~/.ssh/config ~/.ssh/config.backup-$(date +%Y%m%d-%H%M%S)

        # Append 1Password configuration if not present
        echo -e "${YELLOW}Adding 1Password agent to SSH config...${NC}"
        echo "" >> ~/.ssh/config
        echo "# 1Password SSH Agent" >> ~/.ssh/config
        cat "$SCRIPT_DIR/ssh/config" >> ~/.ssh/config
        echo -e "${GREEN}✓ SSH configuration updated${NC}"
    fi
else
    # No existing config, create new one
    cp "$SCRIPT_DIR/ssh/config" ~/.ssh/config
    echo -e "${GREEN}✓ SSH configuration created${NC}"
fi

chmod 600 ~/.ssh/config

# Check if 1Password SSH agent is running
echo -e "${YELLOW}Checking 1Password SSH agent...${NC}"
if [ ! -S ~/.1password/agent.sock ]; then
    echo -e "${YELLOW}⚠ 1Password SSH agent socket not found${NC}"
    echo ""
    echo "Please enable the SSH agent in 1Password:"
    echo "1. Open 1Password desktop app"
    echo "2. Go to Settings → Developer"
    echo "3. Enable 'Use the SSH agent'"
    echo "4. Enable 'Integrate with 1Password CLI'"
    echo ""
    read -p "Press Enter once you've enabled the SSH agent..."
fi

# Check if agent is now available
if [ -S ~/.1password/agent.sock ]; then
    echo -e "${GREEN}✓ 1Password SSH agent detected${NC}"

    # Get SSH public key from 1Password
    echo -e "${YELLOW}Retrieving SSH public key from 1Password...${NC}"
    SSH_KEY=$(SSH_AUTH_SOCK=~/.1password/agent.sock ssh-add -L 2>/dev/null | head -1)

    if [ -z "$SSH_KEY" ]; then
        echo -e "${RED}Error: No SSH keys found in 1Password${NC}"
        echo "Please add an SSH key to 1Password first"
        exit 1
    fi

    echo -e "${GREEN}✓ Found SSH key: $(echo $SSH_KEY | cut -c1-50)...${NC}"

    # Apply git configuration
    echo -e "${YELLOW}Configuring git for SSH signing...${NC}"

    # Set basic signing config
    git config --global gpg.format ssh
    git config --global gpg.ssh.program "/opt/1Password/op-ssh-sign"
    git config --global commit.gpgsign true

    # Set the signing key
    git config --global user.signingkey "$SSH_KEY"

    echo -e "${GREEN}✓ Git signing configuration complete${NC}"

    # Save the public key to a file for reference
    echo "$SSH_KEY" > "$SCRIPT_DIR/git/signing-key.pub"
    echo -e "${GREEN}✓ Public key saved to dotfiles/git/signing-key.pub${NC}"
else
    echo -e "${RED}Error: 1Password SSH agent is not available${NC}"
    echo "Please ensure 1Password is running and SSH agent is enabled"
    exit 1
fi

echo ""
echo -e "${GREEN}=====================================${NC}"
echo -e "${GREEN}  Setup Complete!${NC}"
echo -e "${GREEN}=====================================${NC}"
echo ""
echo "Next steps:"
echo "1. Add your SSH public key to GitHub as a signing key:"
echo "   - Go to: https://github.com/settings/keys"
echo "   - Click 'New SSH key'"
echo "   - Choose type: 'Signing Key'"
echo "   - Paste the key from: $SCRIPT_DIR/git/signing-key.pub"
echo ""
echo "2. Test signing with: git commit -S -m 'test'"
echo "3. Verify with: git log --show-signature -1"