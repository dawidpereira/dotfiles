#!/bin/bash

# Script to copy text and filename based on nvim mode
# Usage: called from nvim with current file path as argument

if [ $# -eq 0 ]; then
  echo "Usage: $0 <filepath> [selected_text] [start_line] [end_line]"
  exit 1
fi

filepath="$1"
selected_text="$2"
start_line="$3"
end_line="$4"

# Get just the filename
filename=$(basename "$filepath")

# Get relative path from current directory
if [[ "$filepath" == /* ]]; then
  # Absolute path - try to make it relative to current directory
  current_dir=$(pwd)
  if [[ "$filepath" == "$current_dir"* ]]; then
    relative_path="${filepath#$current_dir/}"
  else
    relative_path="$filepath"
  fi
else
  relative_path="$filepath"
fi

# If selected text is provided (visual mode)
if [ -n "$selected_text" ]; then
  # Create output with selected text, filename, and line numbers
  if [ "$start_line" = "$end_line" ]; then
    # Single line
    output="File: $relative_path:$start_line

$selected_text"
  else
    # Multiple lines
    output="File: $relative_path:$start_line-$end_line

$selected_text"
  fi

  printf "%s" "$output" | pbcopy
  echo "Copied selected text with filename '$relative_path:$start_line-$end_line' to clipboard!"
else
  # Normal mode - copy filepath with current line number
  if [ -n "$start_line" ]; then
    output="$relative_path:$start_line"
    printf "%s" "$output" | pbcopy
    echo "Copied filepath '$relative_path:$start_line' to clipboard!"
  else
    printf "%s" "$relative_path" | pbcopy
    echo "Copied filepath '$relative_path' to clipboard!"
  fi
fi

