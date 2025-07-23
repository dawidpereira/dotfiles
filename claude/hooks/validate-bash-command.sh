#!/bin/bash

# Claude Code Security Hook: Validate Bash Commands
# This hook prevents dangerous bash commands from being executed

# Read the tool execution data from stdin
tool_data=$(cat)

# Extract the command from the tool data
command=$(echo "$tool_data" | jq -r '.command // empty')

# If no command found, allow the operation
if [[ -z "$command" ]]; then
  exit 0
fi

# Define dangerous command patterns
dangerous_patterns=(
  "rm -rf"
  "rm -fr"
  "sudo rm"
  "chmod 777"
  "chmod -R 777"
  "git push --force"
  "git push -f"
  "git reset --hard HEAD~"
  "docker run --privileged"
  "curl.*\|.*sh"
  "wget.*\|.*sh"
  "dd if="
  "mkfs\."
  "fdisk"
  "parted"
  ":(){ :|:& };:" # Fork bomb
  "eval.*curl"
  "eval.*wget"
  "source.*curl"
  "source.*wget"
  "\|.*passwd"
  "\|.*shadow"
)

# Check if the command matches any dangerous pattern
for pattern in "${dangerous_patterns[@]}"; do
  if [[ "$command" =~ $pattern ]]; then
    echo "🚨 SECURITY ALERT: Dangerous command blocked"
    echo "Command: $command"
    echo "Pattern matched: $pattern"
    echo "This command could be destructive or compromise system security."
    echo ""
    echo "If you need to run this command:"
    echo "1. Review the command carefully for safety"
    echo "2. Run it manually outside of Claude Code"
    echo "3. Consider a safer alternative approach"

    # Return non-zero exit code to block the operation
    exit 1
  fi
done

# Check for suspicious patterns that should be reviewed
suspicious_patterns=(
  "sudo"
  "chmod.*x"
  "chown"
  "systemctl"
  "service "
  "crontab"
  "ssh.*root"
  "su -"
)

for pattern in "${suspicious_patterns[@]}"; do
  if [[ "$command" =~ $pattern ]]; then
    echo "⚠️  WARNING: Potentially risky command detected"
    echo "Command: $command"
    echo "Pattern: $pattern"
    echo "Please review this command carefully before proceeding."
    echo ""
    # Don't block, just warn
    break
  fi
done

# Allow the operation to proceed
exit 0

