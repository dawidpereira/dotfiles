# Dotfiles

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/). Zsh-based setup targeting macOS with Homebrew.

## Requirements

- macOS
- [Homebrew](https://brew.sh)
- Git

## Installation

```bash
# 1. Install Homebrew (if not already installed)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 2. Clone the repository
git clone https://github.com/dawidpereira/dotfiles.git ~/dotfiles
cd ~/dotfiles

# 3. Install all dependencies from the Brewfile
brew bundle --file=Brewfile

# 4. Run the bootstrap script to create symlinks
bash build_symlinks.sh
```

> **Note:** Step 3 is also run inside `build_symlinks.sh`, so you can skip it and go straight to step 4. Running it separately first is useful to catch any brew errors before symlinking.

The bootstrap script will:

1. Install dependencies from the `Brewfile` via `brew bundle` (if not already done)
2. Run `stow .` to symlink config packages into `~/.config/`
3. Create the zsh bootstrap symlink (`~/.zshenv` -> `dotfiles/zsh/zshenv.bootstrap`)
4. Set up Claude Code configuration symlinks
5. Create the IdeaVim symlink (`~/.ideavimrc`)
6. Install Python dependencies for Claude Code skills (requires `uv`)

Open a new terminal and you're done.

## Structure

```
dotfiles/
├── Brewfile                 # Homebrew dependencies
├── build_symlinks.sh        # Bootstrap script
├── .stowrc                  # Stow config (target: ~/.config)
│
├── aerospace/               # Aerospace WM config
├── btop/                    # btop resource monitor
├── claude/                  # Claude Code settings, hooks, skills
├── ghostty/                 # Ghostty terminal config
├── nvim/                    # Neovim (LazyVim) config
├── starship/                # Starship prompt config
├── tmux/                    # tmux config + tpm
├── zsh/                     # Zsh config (.zshrc, .zshenv, bootstrap)
│
├── ideavimrc                # IdeaVim config (symlinked to ~/.ideavimrc)
└── csharpierrc-example.json # Example config (not deployed)
```

Stow deploys each top-level directory as a package into `~/.config/`. Root-level files like `Brewfile` and `build_symlinks.sh` are excluded via `.stowrc`.

## Tools

### CLI Tools

| Tool | Purpose |
|------|---------|
| **bat** | `cat` clone with syntax highlighting |
| **btop** | Resource monitor (CPU, memory, disks, network) |
| **carapace** | Multi-shell completion engine |
| **curl** | URL data transfer tool |
| **eza** | Modern `ls` replacement with icons and git integration |
| **fastfetch** | System information display |
| **fd** | Simple, fast alternative to `find` |
| **ffmpeg** | Multimedia processing |
| **fzf** | Command-line fuzzy finder |
| **gh** | GitHub CLI |
| **gnupg** + **pinentry-mac** | GPG encryption and macOS keychain integration |
| **go** | Go programming language |
| **k9s** | Kubernetes cluster TUI |
| **kubectx** | Switch between Kubernetes contexts/namespaces |
| **lazydocker** | Terminal UI for Docker |
| **lazygit** | Terminal UI for Git |
| **neovim** | Editor (LazyVim distribution) |
| **pandoc** | Universal document converter |
| **ripgrep** | Fast recursive grep |
| **rust-analyzer** | Rust language server |
| **sesh** | Terminal session manager for tmux |
| **starship** | Cross-shell prompt |
| **stow** | Symlink manager for dotfiles |
| **tmux** + **tpm** | Terminal multiplexer with plugin manager |
| **tree-sitter-cli** | Parser generator tool (used by neovim) |
| **uv** | Fast Python package manager |
| **yazi** | Terminal file manager |
| **zoxide** | Smart `cd` replacement |

### Zsh Plugins

| Plugin | Purpose |
|--------|---------|
| **fzf-tab** | Replace zsh completion menu with fzf |
| **zsh-autopair** | Auto-close brackets, quotes, etc. |
| **zsh-autosuggestions** | Fish-like autosuggestions |
| **zsh-syntax-highlighting** | Fish-like syntax highlighting |
| **zsh-you-should-use** | Reminds you of existing aliases |

### Custom Taps

| Tool | Purpose |
|------|---------|
| **rift** | Terminal tool (acsandmann/tap) |
| **suvadu** | Database-backed shell history with fuzzy search |

### Casks (GUI Applications)

| App | Purpose |
|-----|---------|
| **Aerospace** | Tiling window manager |
| **Ghostty** | Terminal emulator |
| **SF Mono Nerd Font Ligaturized** | Patched monospace font |
| **Obsidian** | Markdown knowledge base |
| **Stats** | macOS system monitor in menu bar |
