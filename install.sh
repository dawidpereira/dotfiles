#!/bin/bash
# Dotfiles installer — brew bundle, stow, and manual symlinks

set -e

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DOTFILES"

# ── Helper ────────────────────────────────────────────────────────────
link() {
  local src="$1" dst="$2"
  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    mv "$dst" "${dst}.backup"
    echo "  Backed up $dst"
  elif [ -L "$dst" ]; then
    rm "$dst"
  fi
  ln -s "$src" "$dst"
  echo "  $dst -> $src"
}

# ── Brew bundle ───────────────────────────────────────────────────────
if command -v brew &> /dev/null; then
  echo "Installing dependencies from Brewfile..."
  brew bundle --file="$DOTFILES/Brewfile"
  echo "Done."
else
  echo "Homebrew not found — skipping brew bundle"
fi

# ── Stow (aerospace, btop, ghostty, nvim, scripts, starship) ─────────
echo ""
echo "Running stow..."
stow .
echo "Done."

# ── Zsh ───────────────────────────────────────────────────────────────
echo ""
echo "Setting up zsh..."
mkdir -p ~/.config/zsh
link "$DOTFILES/zsh/zshrc"             ~/.config/zsh/.zshrc
link "$DOTFILES/zsh/zshenv"            ~/.config/zsh/.zshenv
link "$DOTFILES/zsh/zshenv.bootstrap"  ~/.zshenv
echo "Done."

# ── Tmux ──────────────────────────────────────────────────────────────
echo ""
echo "Setting up tmux..."
mkdir -p ~/.config/tmux
link "$DOTFILES/tmux/tmux.conf"       ~/.config/tmux/tmux.conf
link "$DOTFILES/tmux/tmux.reset.conf" ~/.config/tmux/tmux.reset.conf
link "$DOTFILES/tmux/themes"          ~/.config/tmux/themes
echo "Done."

# ── Claude Code ───────────────────────────────────────────────────────
echo ""
echo "Setting up Claude Code..."
SOURCE_CLAUDE="$DOTFILES/claude"
TARGET_CLAUDE="$HOME/.claude"
mkdir -p "$TARGET_CLAUDE"

# Make hook scripts executable
if [ -d "$SOURCE_CLAUDE/hooks" ]; then
  chmod +x "$SOURCE_CLAUDE/hooks"/*.py 2>/dev/null || true
fi

# Individual files
link "$SOURCE_CLAUDE/settings.json"          "$TARGET_CLAUDE/settings.json"
link "$SOURCE_CLAUDE/CLAUDE.md"              "$TARGET_CLAUDE/CLAUDE.md"
link "$SOURCE_CLAUDE/statusline-command.sh"  "$TARGET_CLAUDE/statusline-command.sh"
link "$SOURCE_CLAUDE/claude.json"            "$HOME/.claude.json"

# Directories
link "$SOURCE_CLAUDE/commands" "$TARGET_CLAUDE/commands"
link "$SOURCE_CLAUDE/hooks"    "$TARGET_CLAUDE/hooks"
link "$SOURCE_CLAUDE/skills"   "$TARGET_CLAUDE/skills"

# Install excalidraw skill dependencies
REFERENCES_DIR="$SOURCE_CLAUDE/skills/excalidraw-diagram/references"
if [ -f "$REFERENCES_DIR/pyproject.toml" ] && command -v uv &> /dev/null; then
  echo "  Installing excalidraw skill dependencies..."
  (cd "$REFERENCES_DIR" && uv sync)
  (cd "$REFERENCES_DIR" && uv run playwright install chromium)
fi
echo "Done."

# ── IdeaVim ───────────────────────────────────────────────────────────
echo ""
echo "Setting up IdeaVim..."
link "$DOTFILES/ideavimrc" ~/.ideavimrc
echo "Done."

echo ""
echo "Installation complete. Open a new terminal to apply changes."
