# Dotfiles Repository
This repository contains my personal dotfiles and a curated list of essential plugins and applications used in my daily workflow. It is designed for rapid setup and environment consistency across systems.

## Requirements
Make sure the following software is installed on your system before proceeding:

- Git

## Installation
To install these dotfiles, clone the repository into your home directory:

```bash
$ git clone https://github.com/dawidpereira/dotfiles.git ~/dotfiles
```

### Set up symlinks
Use GNU Stow to manage and create the necessary symbolic links:

```bash
cd ~/dotfiles
```

```bash
$ bash build_symlinks.sh
```

## Applications & Plugins Overview
> [!NOTE]
> The initial setup was based on Nix and Darwin. However, due to frequent compatibility issues—primarily from differing installation paths and interdependent plugins requiring manual path configuration this repository now favors a more conventional approach.

### Apliations
- **Arc** **Browser** - Next-generation web browser designed for speed, privacy, and user experience.
- **Bazecor** - Customizable RGB lighting and peripheral management application.
- **Docker** - Platform for building, running, and managing containerized applications.
- **Discord** - Communication platform for text, voice, and video, popular in developer and gaming communities.
- **Ghostty** - Fast, modern terminal emulator focused on performance and simplicity.
- **Homerow** - Keyboard productivity tool that enhances navigation and efficiency.
- **Obsidian** - Markdown-based knowledge base and note-taking application with powerful linking features.
- **Oto** **Navi** - Audio device routing and management utility.
- **Raycast** - Productivity launcher for macOS that enables quick access to workflows, scripts, and applications. 
- **Remarkable** - Digital paper tablet and application for note-taking and document annotation.

Plugins & Terminal Tools
- **Aerospace** - Productivity enhancements and extra commands for the terminal.
- **Neovim** - Extensible and highly configurable Vim-based text editor.
- **Nushell** - Modern shell leveraging structured data and pipelines.
- **btop** - Resource monitor for CPU, memory, disks, and network usage.
- **fzf** - Command-line fuzzy finder for searching files, history, and more.
- **fd** - Simple, fast, and user-friendly alternative to `find`.
- **git** - Distributed version control system.
- **gh** - GitHub CLI for managing repositories and workflows from the command line.
- **kubectx** - Utility for efficiently switching between Kubernetes contexts.
- **lazygit** - Simple terminal UI for Git commands.
- **lazydocker** - Terminal UI for managing Docker containers, images, and more.
- **ripgrep** - Fast recursive search tool using regex.
- **sesh** - Terminal session manager for improved multitasking.
- **starship** - Fast and customizable shell prompt for any shell environment.
- **stow** - Symlink manager for organizing and deploying dotfiles.
- **tmux** - Terminal multiplexer to manage multiple terminal sessions.
- **tpm** - Tmux Plugin Manager for plugin management in tmux.
- **yazi** - Terminal-based file explorer focused on speed and usability.
- **zoxide** - Smarter directory jumper that learns your navigation habits.
