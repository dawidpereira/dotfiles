#!/bin/bash

# Claude Code Security Hook: Protect Sensitive Files
# This hook prevents access to environment files and other sensitive data

# Read the tool execution data from stdin
tool_data=$(cat)

# Extract the file path from the tool data
file_path=$(echo "$tool_data" | jq -r '.file_path // empty')

# If no file path found, allow the operation
if [[ -z "$file_path" ]]; then
  exit 0
fi

# Convert relative paths to absolute paths
if [[ "$file_path" != /* ]]; then
  file_path="$(pwd)/$file_path"
fi

# Define sensitive file patterns
sensitive_patterns=(
  "\.env"
  "\.env\."
  "secrets\."
  "secret"
  "\.key"
  "\.pem"
  "\.p12"
  "\.pfx"
  "credentials"
  "password"
  "auth\.json"
  "\.netrc"
  "id_rsa"
  "id_ed25519"
  "config\.json.*auth"
)

# Check if the file matches any sensitive pattern
for pattern in "${sensitive_patterns[@]}"; do
  if [[ "$file_path" =~ $pattern ]]; then
    echo "🚨 SECURITY ALERT: Access to sensitive file blocked"
    echo "File: $file_path"
    echo "Pattern matched: $pattern"
    echo "This file may contain secrets, credentials, or other sensitive data."
    echo ""
    echo "If you need to access this file:"
    echo "1. Ensure it doesn't contain real secrets"
    echo "2. Use a different filename that doesn't match sensitive patterns"
    echo "3. Temporarily disable this hook if absolutely necessary"

    # Return non-zero exit code to block the operation
    exit 1
  fi
done

# If no sensitive patterns matched, allow the operation
exit 0

