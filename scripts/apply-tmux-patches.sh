#!/usr/bin/env bash
# Patches tmux2k git plugin to use --no-optional-locks, preventing
# git lock file conflicts with user git operations.

TARGET="$HOME/.config/tmux/plugins/tmux2k/plugins/git.sh"

if [ -f "$TARGET" ]; then
    if ! grep -q '\-\-no-optional-locks' "$TARGET"; then
        sed -i '' 's/git -C "$path"/git --no-optional-locks -C "$path"/g' "$TARGET"
        echo "Patched tmux2k git.sh with --no-optional-locks"
    fi
fi
