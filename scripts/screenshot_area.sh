#!/bin/bash

# Take a screenshot of selected area
timestamp=$(/bin/date +%Y%m%d_%H%M%S)
filename="Screenshot_${timestamp}.png"

# Create screenshots directory on Desktop
screenshots_dir="$HOME/Desktop/screenshots"
/bin/mkdir -p "$screenshots_dir"

filepath="$screenshots_dir/$filename"

# Take screenshot with selection (macOS)
/usr/sbin/screencapture -i "$filepath"

# Check if screenshot was taken (user didn't cancel)
if [ -f "$filepath" ]; then
    # Copy full path to clipboard
    echo -n "$filepath" | /usr/bin/pbcopy
    echo "Screenshot saved to: $filepath"
    echo "Path copied to clipboard!"
else
    echo "Screenshot cancelled."
fi