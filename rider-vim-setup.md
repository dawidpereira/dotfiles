# Rider Vim Setup Guide

## Essential Plugins to Install

### 1. **IdeaVim** (Core - Required)

- **What it does**: Provides Vim emulation in JetBrains IDEs
- **Install**: Settings → Plugins → Search "IdeaVim"

### 2. **AceJump** (Highly Recommended)

- **What it does**: Provides the 's' motion you mentioned - search for a character/word and jump directly to it
- **Install**: Settings → Plugins → Search "AceJump"
- **Usage**: Press `s` followed by the target characters, then the highlighted letter to jump

### 3. **IdeaVim-EasyMotion** (Alternative to AceJump)

- **What it does**: More advanced motion plugin with multiple jump modes
- **Install**: Enable in `.ideavimrc` with `set easymotion` (already configured)
- **Usage**: `s` for 2-char search, `S` for cross-window search

### 4. **Which Key** (Recommended)

- **What it does**: Shows available keybindings in a popup (like which-key in nvim)
- **Install**: Settings → Plugins → Search "Which Key"
- **Usage**: Press leader key and wait to see available commands

### 5. **Key Promoter X** (Recommended for Learning)

- **What it does**: Shows keyboard shortcuts for actions you perform with mouse
- **Install**: Settings → Plugins → Search "Key Promoter X"
- **Usage**: Automatically shows shortcuts when you use menu/mouse

### 6. **Relative Line Numbers** (Optional)

- **What it does**: Better relative line number support
- **Install**: Settings → Plugins → Search "Relative Line Numbers"
- **Note**: May not be needed as `.ideavimrc` already configures this

## Quick Start

1. **Copy the .ideavimrc file to your home directory:**

   ```bash
   cp /Users/dawidpereira/dotfiles/.ideavimrc ~/
   ```

2. **Restart Rider** or reload the config:
   - In Rider, type: `:source ~/.ideavimrc`

3. **Configure IdeaVim:**
   - Go to Settings → Editor → Vim
   - Ensure "Use Vim" is checked
   - Set handler conflicts (recommend IDE for most, Vim for navigation)

## Key Mappings Overview

### Leader Key = Space

| Key | Action | Description |
|-----|--------|-------------|
| **File Navigation** |
| `<leader>ff` | Find Files | Search files in project |
| `<leader>fr` | Recent Files | Show recent files |
| `<leader>e` | File Explorer | Toggle file tree |
| **Code Navigation** |
| `gd` | Go to Definition | Jump to definition |
| `gr` | Find Usages | Show all usages |
| `K` | Quick Documentation | Show docs popup |
| **Search** |
| `<leader>/` | Search in Project | Global search |
| `<leader>sw` | Search Word | Search current word |
| `<leader>ss` | Search Everything | Universal search |
| **Git** |
| `<leader>gs` | Git Status | Show git changes |
| `<leader>gb` | Git Blame | Show blame annotations |
| `<leader>gd` | Git Diff | Show file diff |
| **Testing** |
| `<leader>tt` | Run Test | Run current test |
| `<leader>td` | Debug Test | Debug current test |
| **Code Actions** |
| `<leader>ca` | Code Actions | Show available actions |
| `<leader>cr` | Rename | Rename symbol |
| `<leader>cf` | Format Code | Format file/selection |

### Motion with AceJump/EasyMotion

- `s` + 2 chars: Jump to any occurrence of those 2 characters
- `S`: Cross-window jump
- Works exactly like your vim 's' motion

### Custom Mappings from Your Config

- `jj` / `kk`: Escape from insert mode
- `U`: Redo (instead of Ctrl-R)
- `<C-h/j/k/l>`: Window navigation (like tmux)
- `<S-h/l>`: Previous/Next buffer (tab)

## Handling Conflicts

Some keys might conflict between IdeaVim and IDE. Configure in:
**Settings → Editor → Vim → Shortcut Conflicts**

Recommended settings:

- Navigation (hjkl, gg, G): **Vim**
- Code completion (Ctrl+Space): **IDE**
- Find/Replace dialogs: **IDE**
- Debugging: **IDE**

## Customization Tips

1. **To find action names for mapping:**
   - In Rider: `:actionlist [pattern]`
   - Example: `:actionlist refactor`

2. **To test a mapping:**
   - `:action ActionName`
   - Example: `:action GotoDeclaration`

3. **To reload config:**
   - `:source ~/.ideavimrc`

4. **For .NET specific features:**
   - ReSharper actions are prefixed with `ReSharper.`
   - Use `:actionlist ReSharper` to find them

## Differences from LazyVim

| LazyVim Feature | Rider Equivalent | Notes |
|-----------------|------------------|-------|
| Telescope | Search Everywhere (`<leader>ss`) | Universal search |
| LSP hover | Quick Doc (`K`) | Shows inline documentation |
| nvim-tree | Project View (`<leader>e`) | Built-in file explorer |
| Lazy.nvim | IDE Plugins | Managed through Settings |
| Flash.nvim | AceJump/EasyMotion | Similar jump functionality |

## Troubleshooting

1. **Relative numbers not working:**
   - Check Settings → Editor → General → Appearance → Show line numbers
   - Ensure `set relativenumber` is in `.ideavimrc`

2. **Leader key not working:**
   - Ensure no conflicts in Settings → Keymap
   - Try `:echo mapleader` to verify it's set to space

3. **Plugin commands not working:**
   - Verify plugin is installed and enabled
   - Check `:actionlist` to find correct action names

4. **Slow performance:**
   - Disable some IdeaVim plugins if needed
   - Increase IDE memory in Help → Change Memory Settings

## Additional Resources

- [IdeaVim Repository](https://github.com/JetBrains/ideavim)
- [IdeaVim Plugin List](https://github.com/JetBrains/ideavim/wiki/IdeaVim-Plugins)
- [Action IDs Reference](https://gist.github.com/zchee/9c78f91cc5ad771c1f5d)

