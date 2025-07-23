#!/bin/bash

# Claude Code macOS Notification Hook: User Attention Required
# This hook sends alerts when Claude needs user input or attention

# Read the tool execution data from stdin
tool_data=$(cat)

# Extract notification content if available
notification_content=$(echo "$tool_data" | jq -r '.notification // empty')

# If no specific notification content, use a generic message
if [[ -z "$notification_content" ]]; then
  notification_content="Claude Code needs your attention"
fi

# Get current timestamp
timestamp=$(date "+%H:%M:%S")

# Determine sound based on urgency keywords
urgent_keywords=("error" "failed" "critical" "warning" "blocked" "permission")
is_urgent=false

for keyword in "${urgent_keywords[@]}"; do
  if [[ "$notification_content" == *"$keyword"* ]]; then
    is_urgent=true
    break
  fi
done

# Set sound based on urgency
if [[ "$is_urgent" == true ]]; then
  sound_option="sound name \"Sosumi\"" # More attention-grabbing sound
else
  sound_option="sound name \"Ping\"" # Gentle sound
fi

# Send macOS notification with appropriate urgency
osascript -e "
display notification \"$notification_content\" \\
    with title \"🤖 Claude Code Alert\" \\
    subtitle \"Action required - $timestamp\" \\
    $sound_option
"

# For urgent notifications, also show an alert dialog
if [[ "$is_urgent" == true ]]; then
  osascript -e "
    display alert \"Claude Code Needs Attention\" \\
        message \"$notification_content\" \\
        as critical \\
        buttons {\"OK\"} \\
        default button \"OK\"
    " &
fi

# Terminal bell for immediate attention
echo -e "\a"

# Log the notification for debugging
echo "[$(date)] Claude notification: $notification_content" >>"/tmp/claude-notifications.log"

exit 0

