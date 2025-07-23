# Git Commit Helper

## Overview
This command helps you create well-structured git commits following best practices and conventions.

## Usage
```
/commit [options]
```

## Options
- `--type <type>` - Commit type (feat, fix, docs, style, refactor, perf, test, build, ci, chore, revert)
- `--scope <scope>` - Component or area affected (optional)
- `--breaking` - Mark as breaking change
- `--amend` - Amend the previous commit
- `--no-verify` - Skip pre-commit hooks
- `--dry-run` - Show what would be committed without committing

## Commit Message Format
```
<type>(<scope>): <subject>

<body>

<footer>
```

## Commit Types
- **feat**: New feature
- **fix**: Bug fix
- **docs**: Documentation changes
- **style**: Code style changes (formatting, missing semicolons, etc.)
- **refactor**: Code refactoring without changing functionality
- **perf**: Performance improvements
- **test**: Adding or updating tests
- **build**: Build system or dependency changes
- **ci**: CI/CD configuration changes
- **chore**: Maintenance tasks
- **revert**: Reverting a previous commit

## Best Practices
1. **Keep the subject line under 50 characters**
2. **Use imperative mood** ("Add feature" not "Added feature")
3. **Capitalize the first letter**
4. **Don't end with a period**
5. **Separate subject from body with blank line**
6. **Explain what and why, not how**
7. **Reference issues and pull requests**

## Examples

### Simple commit
```
/commit --type feat --scope auth "Add two-factor authentication"
```

### Commit with body
```
/commit --type fix --scope api "Resolve race condition in user update"

The user update endpoint was allowing concurrent updates which could
lead to data inconsistency. This fix adds proper locking mechanism
to ensure atomic updates.

Fixes #123
```

### Breaking change
```
/commit --type feat --scope api --breaking "Change API response format"

BREAKING CHANGE: API responses now use camelCase instead of snake_case
for all field names. Clients need to update their parsing logic.
```

## Workflow Steps

1. **Stage changes**
   ```bash
   git add <files>
   # or
   git add -p  # for interactive staging
   ```

2. **Review staged changes**
   ```bash
   git diff --staged
   ```

3. **Create commit**
   - Use conventional commit format
   - Write clear, descriptive message
   - Reference related issues

4. **Verify commit**
   ```bash
   git log -1 --oneline
   git show HEAD
   ```

## Pre-commit Checklist
- [ ] Code is formatted (`cargo fmt`, `dotnet format`, etc.)
- [ ] Tests pass (`cargo test`, `dotnet test`, etc.)
- [ ] Linting passes (`cargo clippy`, etc.)
- [ ] No sensitive data or secrets
- [ ] Documentation updated if needed
- [ ] Breaking changes noted
- [ ] Related issues referenced

## Git Configuration
Ensure your git is properly configured:
```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
git config --global core.editor "vim"  # or your preferred editor
```

## Useful Git Commands
```bash
# Show commit history
git log --oneline --graph --all

# Show specific commit
git show <commit-hash>

# Undo last commit (keep changes)
git reset --soft HEAD~1

# Undo last commit (discard changes)
git reset --hard HEAD~1

# Interactive rebase
git rebase -i HEAD~3

# Cherry-pick commit
git cherry-pick <commit-hash>
```

## Hooks Integration
This command respects your configured git hooks:
- Pre-commit: Code formatting, linting, tests
- Commit-msg: Validate commit message format
- Post-commit: Notifications, metrics

Use `--no-verify` to skip hooks when necessary.
