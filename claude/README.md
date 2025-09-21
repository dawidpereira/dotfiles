# Claude Code Configuration

This directory contains configuration files for Claude Code CLI, including custom commands, security hooks, and development guidelines.

## Structure

- `CLAUDE.md` - Global development guidelines and best practices
- `settings.json` - Claude Code settings with security rules and hooks
- `commands/` - Custom slash commands for common workflows
- `hooks/` - Security and automation hooks

## Installation

The `build_symlinks.sh` script in the parent directory will automatically:
1. Create symlinks for Claude Code configuration files
2. Set executable permissions on all hook scripts
3. Back up any existing configuration files

## Custom Commands

- `/review` - Comprehensive code review
- `/rust-new` - Create new Rust project with best practices
- `/dotnet-new` - Create new .NET project with best practices
- `/test-focus` - Run tests intelligently based on changes
- `/security-check` - Perform security vulnerability scanning
- `/deploy-check` - Pre-deployment validation

## Security Hooks

The configuration includes several security hooks:
- **protect-sensitive-files.sh** - Prevents access to sensitive files like `.env`, secrets, and credentials
- **validate-bash-command.sh** - Blocks dangerous commands like `rm -rf`, `sudo rm`, etc.
- **post-edit-checks.sh** - Runs automatic formatting and linting after file edits

## Configuration Options

### Notification Behavior

To enable duplicate notifications (two notifications per completion), set the environment variable:
```bash
export CLAUDE_DUPLICATE_NOTIFICATIONS=true
```

By default, only one notification is sent.

## Requirements

- `jq` - Required for hook scripts to parse JSON data
- Language-specific tools (optional but recommended):
  - Rust: `cargo`, `rustfmt`, `clippy`
  - .NET: `dotnet` CLI
  - Node.js: `prettier`, `eslint`
  - Python: `black`, `ruff`
  - Go: `go fmt`, `go vet`

## Troubleshooting

If hooks are not working:
1. Ensure `jq` is installed: `brew install jq`
2. Check that hook scripts are executable: `chmod +x hooks/*.sh`
3. Verify paths in `settings.json` are absolute paths
4. Check Claude Code logs for any error messages