#!/bin/bash

# Take a full screen screenshot
timestamp=$(/bin/date +%Y%m%d_%H%M%S)
filename="Screenshot_Full_${timestamp}.png"

# Create screenshots directory on Desktop
screenshots_dir="$HOME/Desktop/screenshots"
/bin/mkdir -p "$screenshots_dir"

filepath="$screenshots_dir/$filename"

# Take full screen screenshot (macOS)
/usr/sbin/screencapture "$filepath"

# Check if screenshot was taken
if [ -f "$filepath" ]; then
    # Copy full path to clipboard
    echo -n "$filepath" | /usr/bin/pbcopy
    echo "Screenshot saved to: $filepath"
    echo "Path copied to clipboard!"
else
    echo "Screenshot failed."
fi