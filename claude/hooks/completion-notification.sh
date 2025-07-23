#!/bin/bash

# Claude Code macOS Notification Hook: Task Completion
# This hook sends native macOS notifications when Claude finishes tasks

# Read the tool execution data from stdin (though Stop event may not have much data)
tool_data=$(cat)

# Get current timestamp for the notification
timestamp=$(date "+%H:%M:%S")

# Sound notification based on time of day
current_hour=$(date "+%H")
if [[ $current_hour -ge 22 || $current_hour -le 7 ]]; then
  # Quiet hours - no sound
  sound_option=""
else
  # Normal hours - gentle sound
  sound_option="sound name \"Glass\""
fi

# Send macOS notification
osascript -e "
display notification \"Claude Code has finished processing your request.\" \\
    with title \"🤖 Claude Code Complete\" \\
    subtitle \"Task finished at $timestamp\" \\
    $sound_option
"

# Optional: Terminal bell for immediate attention
echo -e "\a"

# Optional: Add to macOS notification center with longer persistence
osascript -e "
set notificationText to \"Claude Code task completed at $timestamp. Check your terminal for results.\"
display notification notificationText \\
    with title \"Claude Code\" \\
    subtitle \"Ready for next task\" \\
    $sound_option
"

# Log completion for debugging (optional)
echo "[$(date)] Claude Code task completion notification sent" >>"/tmp/claude-notifications.log"

exit 0

