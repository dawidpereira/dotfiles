---
name: dotfiles-guide
description: How the dotfiles repo is structured and how to add new tools, configs, or CLI programs. Use this skill whenever the user is working in the dotfiles repo and wants to add a new program, plugin, Neovim config, CLI tool, brew formula, or any configuration file. Also use it when the user asks about how stow works in this repo, how symlinks are set up, or how install.sh works. Trigger for any dotfiles modification task — even if the user just says "add X to my setup" or "configure Y".
---

# Dotfiles Guide

This repo lives at `~/dotfiles` and manages configuration for macOS using GNU Stow, manual symlinks, and Homebrew.

## How the repo is organized

There are two symlink strategies depending on the tool:

### Strategy 1: Stow (automatic symlinks to `~/.config`)

`.stowrc` sets `--target=~/.config`, so running `stow .` from the repo root creates symlinks from `~/.config/<dir>` to `~/dotfiles/<dir>` for every top-level directory that isn't ignored.

**Stow-managed directories** (symlinked automatically):
- `aerospace/` -> `~/.config/aerospace/`
- `btop/` -> `~/.config/btop/`
- `ghostty/` -> `~/.config/ghostty/`
- `nvim/` -> `~/.config/nvim/`
- `scripts/` -> `~/.config/scripts/`
- `starship/` -> `~/.config/starship/`

**Ignored by stow** (listed in `.stowrc`): `zsh/`, `tmux/`, `claude/`, `ideavimrc`, loose files at root like `Brewfile`, `install.sh`, `README.md`, etc.

### Strategy 2: Manual symlinks in `install.sh`

Some tools need files in specific locations outside `~/.config`. The `install.sh` script uses a `link()` helper that backs up existing files before symlinking:

- **zsh**: `zsh/zshrc` -> `~/.config/zsh/.zshrc`, `zsh/zshenv` -> `~/.config/zsh/.zshenv`, `zsh/zshenv.bootstrap` -> `~/.zshenv`
- **tmux**: `tmux/tmux.conf` -> `~/.config/tmux/tmux.conf`, `tmux/tmux.reset.conf` -> `~/.config/tmux/tmux.reset.conf`
- **claude**: `claude/` files and directories -> `~/.claude/` (settings, hooks, commands, skills)
- **ideavimrc**: `ideavimrc` -> `~/.ideavimrc`

## How to add a new tool or config

### If it goes in `~/.config/<toolname>/`

This is the common case. Most CLI tools read from `~/.config/<toolname>/`.

1. Create the directory: `mkdir ~/dotfiles/<toolname>`
2. Put config files inside it with the same structure the tool expects under `~/.config/<toolname>/`
3. Run `stow .` (or `./install.sh`) — stow handles the symlink automatically
4. If it's a brew package, add it to `Brewfile`

**Example — adding `yazi` config:**
```
mkdir ~/dotfiles/yazi
# put yazi.toml, keymap.toml, etc. inside ~/dotfiles/yazi/
# stow will create ~/.config/yazi -> ~/dotfiles/yazi
```

### If it needs a non-standard location

Some tools read config from `~/.<something>` or other paths outside `~/.config/`.

1. Create the directory or file in `~/dotfiles/`
2. Add the directory name to `.stowrc` ignore list (to prevent stow from touching it)
3. Add manual `link` calls in `install.sh` under a new section
4. If it's a brew package, add it to `Brewfile`

### Adding a brew formula or cask

Edit `Brewfile` and add the appropriate line:
- CLI tool: `brew "<name>"`
- GUI app: `cask "<name>"`
- Custom tap: first `tap "<org>/<repo>"`, then `brew "<org>/<repo>/<name>"`

`install.sh` runs `brew bundle` automatically.

## Adding Neovim plugins

Neovim config is at `nvim/lua/plugins/`. Each plugin gets its own file (LazyVim convention):

1. Create `nvim/lua/plugins/<plugin-name>.lua`
2. Return a table with the plugin spec:
```lua
return {
  "<github-org>/<plugin-name>",
  -- optional fields: dependencies, cmd, keys, opts, config, etc.
}
```

LazyVim auto-loads everything in `nvim/lua/plugins/`.

## Adding Claude Code config

Claude config lives in `claude/` and gets symlinked to `~/.claude/`:
- **Commands** (slash commands): add `.md` files to `claude/commands/`
- **Skills**: add a directory with `SKILL.md` to `claude/skills/`
- **Hooks**: add scripts to `claude/hooks/`
- **Settings**: edit `claude/settings.json`

## Key files reference

| File | Purpose |
|------|---------|
| `install.sh` | Main installer — brew bundle + stow + manual links |
| `.stowrc` | Stow config: target dir and ignore patterns |
| `Brewfile` | Homebrew dependencies |
| `.gitignore` | Files excluded from git |

## Checklist for any dotfiles change

1. Put config files in the right place (stow dir or manual link dir)
2. If manual linking is needed, update `.stowrc` ignore list AND `install.sh`
3. If it's a brew package, add to `Brewfile`
4. Verify symlinks work: run `./install.sh` or `stow .`
