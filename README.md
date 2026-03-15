# Dotfiles

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/)
and manual symlinks. Zsh-based setup targeting macOS with Homebrew.

## Requirements

- macOS
- [Homebrew](https://brew.sh)
- Git

## Installation

```bash
# 1. Install Homebrew (if not already installed)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 2. Clone and install
git clone https://github.com/dawidpereira/dotfiles.git ~/dotfiles
cd ~/dotfiles
bash install.sh
```

The install script will:

1. Install dependencies from the `Brewfile` via `brew bundle`
2. Run `stow .` to symlink config packages into `~/.config/` (aerospace, btop,
   ghostty, nvim, scripts, starship)
3. Create zsh symlinks (`~/.config/zsh/.zshrc`, `~/.config/zsh/.zshenv`,
   `~/.zshenv`)
4. Create tmux symlinks (`~/.config/tmux/tmux.conf`,
   `~/.config/tmux/tmux.reset.conf`)
5. Set up Claude Code configuration symlinks in `~/.claude/`
6. Create the IdeaVim symlink (`~/.ideavimrc`)
7. Install Python dependencies for Claude Code skills (requires `uv`)

Open a new terminal and you're done.

## Structure

```
dotfiles/
├── Brewfile                 # Homebrew dependencies
├── install.sh               # Bootstrap script
├── .stowrc                  # Stow config (target: ~/.config)
│
├── aerospace/               # Aerospace WM config
├── btop/                    # btop resource monitor
├── claude/                  # Claude Code settings, hooks, skills
├── ghostty/                 # Ghostty terminal config
├── nvim/                    # Neovim (LazyVim) config
├── scripts/                 # Custom scripts
├── starship/                # Starship prompt config
├── tmux/                    # tmux config (tmux.conf, tmux.reset.conf)
├── zsh/                     # Zsh config (zshrc, zshenv, zshenv.bootstrap)
│
├── ideavimrc                # IdeaVim config (symlinked to ~/.ideavimrc)
└── csharpierrc-example.json # Example config (not deployed)
```

Stow deploys `aerospace`, `btop`, `ghostty`, `nvim`, `scripts`, and `starship`
into `~/.config/`. Zsh, tmux, and Claude Code are symlinked manually by
`install.sh` to avoid stow's tree-folding behavior.

## Tools

### CLI Tools

| Tool                         | Purpose                                                |
| ---------------------------- | ------------------------------------------------------ |
| **bat**                      | `cat` clone with syntax highlighting                   |
| **btop**                     | Resource monitor (CPU, memory, disks, network)         |
| **carapace**                 | Multi-shell completion engine                          |
| **curl**                     | URL data transfer tool                                 |
| **eza**                      | Modern `ls` replacement with icons and git integration |
| **fastfetch**                | System information display                             |
| **fd**                       | Simple, fast alternative to `find`                     |
| **ffmpeg**                   | Multimedia processing                                  |
| **fzf**                      | Command-line fuzzy finder                              |
| **gh**                       | GitHub CLI                                             |
| **gnupg** + **pinentry-mac** | GPG encryption and macOS keychain integration          |
| **go**                       | Go programming language                                |
| **k9s**                      | Kubernetes cluster TUI                                 |
| **kubectx**                  | Switch between Kubernetes contexts/namespaces          |
| **lazydocker**               | Terminal UI for Docker                                 |
| **lazygit**                  | Terminal UI for Git                                    |
| **neovim**                   | Editor (LazyVim distribution)                          |
| **pandoc**                   | Universal document converter                           |
| **ripgrep**                  | Fast recursive grep                                    |
| **rust-analyzer**            | Rust language server                                   |
| **sesh**                     | Terminal session manager for tmux                      |
| **starship**                 | Cross-shell prompt                                     |
| **stow**                     | Symlink manager for dotfiles                           |
| **tmux** + **tpm**           | Terminal multiplexer with plugin manager               |
| **tree-sitter-cli**          | Parser generator tool (used by neovim)                 |
| **uv**                       | Fast Python package manager                            |
| **yazi**                     | Terminal file manager                                  |
| **zoxide**                   | Smart `cd` replacement                                 |

### Zsh Plugins

| Plugin                      | Purpose                              |
| --------------------------- | ------------------------------------ |
| **fzf-tab**                 | Replace zsh completion menu with fzf |
| **zsh-autopair**            | Auto-close brackets, quotes, etc.    |
| **zsh-autosuggestions**     | Fish-like autosuggestions            |
| **zsh-syntax-highlighting** | Fish-like syntax highlighting        |
| **zsh-you-should-use**      | Reminds you of existing aliases      |

### Custom Taps

| Tool       | Purpose                                         |
| ---------- | ----------------------------------------------- |
| **rift**   | Terminal tool (acsandmann/tap)                  |
| **suvadu** | Database-backed shell history with fuzzy search |

### Casks (GUI Applications)

| App                               | Purpose                          |
| --------------------------------- | -------------------------------- |
| **Aerospace**                     | Tiling window manager            |
| **Ghostty**                       | Terminal emulator                |
| **SF Mono Nerd Font Ligaturized** | Patched monospace font           |
| **Obsidian**                      | Markdown knowledge base          |
| **Stats**                         | macOS system monitor in menu bar |
