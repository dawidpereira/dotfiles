#!/bin/bash

# Claude Code Post-Edit Hook: Automated Quality Checks
# This hook runs quality checks after file edits

# Read the tool execution data from stdin
tool_data=$(cat)

# Extract the file path from the tool data
file_path=$(echo "$tool_data" | jq -r '.file_path // empty')

# If no file path found, exit silently
if [[ -z "$file_path" ]]; then
  exit 0
fi

# Convert relative paths to absolute paths
if [[ "$file_path" != /* ]]; then
  file_path="$(pwd)/$file_path"
fi

# Only proceed if the file exists
if [[ ! -f "$file_path" ]]; then
  exit 0
fi

# Get file extension
extension="${file_path##*.}"

echo "🔍 Running post-edit checks for: $(basename "$file_path")"

# Rust files
if [[ "$extension" == "rs" ]]; then
  # Check if we're in a Rust project (has Cargo.toml)
  if [[ -f "Cargo.toml" ]] || find . -name "Cargo.toml" -maxdepth 3 2>/dev/null | grep -q .; then
    echo "  📦 Rust project detected"

    # Format the code
    if command -v cargo >/dev/null 2>&1; then
      echo "  🎨 Running cargo fmt..."
      cargo fmt 2>/dev/null || echo "     ⚠️  cargo fmt failed"
    fi

    # Run clippy for linting
    if command -v cargo >/dev/null 2>&1; then
      echo "  🔍 Running cargo clippy (quick check)..."
      timeout 10s cargo clippy --quiet -- -D warnings 2>/dev/null || echo "     ⚠️  clippy warnings detected"
    fi

    # Quick syntax check
    if command -v cargo >/dev/null 2>&1; then
      echo "  ✅ Running cargo check..."
      timeout 10s cargo check --quiet 2>/dev/null || echo "     ❌ cargo check failed"
    fi
  fi
fi

# C# / .NET files
if [[ "$extension" == "cs" ]]; then
  # Check if we're in a .NET project (has .csproj, .sln, or .fsproj)
  if find . -name "*.csproj" -o -name "*.sln" -o -name "*.fsproj" -maxdepth 3 2>/dev/null | grep -q .; then
    echo "  📦 .NET project detected"

    # Format the code
    if command -v dotnet >/dev/null 2>&1; then
      echo "  🎨 Running dotnet format..."
      timeout 10s dotnet format --include "$file_path" --verbosity quiet 2>/dev/null || echo "     ⚠️  dotnet format failed"
    fi

    # Build check
    if command -v dotnet >/dev/null 2>&1; then
      echo "  ✅ Running dotnet build..."
      timeout 15s dotnet build --verbosity quiet --nologo 2>/dev/null || echo "     ❌ dotnet build failed"
    fi
  fi
fi

# JavaScript/TypeScript files
if [[ "$extension" == "js" || "$extension" == "ts" || "$extension" == "jsx" || "$extension" == "tsx" ]]; then
  # Check for package.json
  if [[ -f "package.json" ]]; then
    echo "  📦 Node.js project detected"

    # Run Prettier if available
    if command -v prettier >/dev/null 2>&1; then
      echo "  🎨 Running prettier..."
      prettier --write "$file_path" 2>/dev/null || echo "     ⚠️  prettier failed"
    fi

    # Run ESLint if available
    if command -v eslint >/dev/null 2>&1; then
      echo "  🔍 Running eslint..."
      eslint --fix "$file_path" 2>/dev/null || echo "     ⚠️  eslint warnings detected"
    fi

    # TypeScript check
    if [[ "$extension" == "ts" || "$extension" == "tsx" ]] && command -v tsc >/dev/null 2>&1; then
      echo "  ✅ Running TypeScript check..."
      timeout 10s tsc --noEmit 2>/dev/null || echo "     ❌ TypeScript errors detected"
    fi
  fi
fi

# Python files
if [[ "$extension" == "py" ]]; then
  # Run black formatter if available
  if command -v black >/dev/null 2>&1; then
    echo "  🎨 Running black formatter..."
    black "$file_path" --quiet 2>/dev/null || echo "     ⚠️  black formatting failed"
  fi

  # Run ruff linter if available
  if command -v ruff >/dev/null 2>&1; then
    echo "  🔍 Running ruff linter..."
    ruff check --fix "$file_path" 2>/dev/null || echo "     ⚠️  ruff warnings detected"
  fi

  # Check Python syntax
  if command -v python3 >/dev/null 2>&1; then
    echo "  ✅ Checking Python syntax..."
    python3 -m py_compile "$file_path" 2>/dev/null || echo "     ❌ Python syntax errors detected"
  fi
fi

# Go files
if [[ "$extension" == "go" ]]; then
  if command -v go >/dev/null 2>&1; then
    echo "  📦 Go project detected"

    # Format the code
    echo "  🎨 Running go fmt..."
    go fmt "$file_path" 2>/dev/null || echo "     ⚠️  go fmt failed"

    # Run go vet
    echo "  🔍 Running go vet..."
    go vet "$file_path" 2>/dev/null || echo "     ⚠️  go vet warnings detected"
  fi
fi

echo "  ✨ Post-edit checks completed"

# Always exit successfully to not block the workflow
exit 0

