#!/bin/bash
# Full screenshot for Linux/Wayland

# Use grim for Wayland (Omarchy uses Hyprland)
if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    grim - | wl-copy
    notify-send "Screenshot" "Full screenshot copied to clipboard"
else
    # Fallback for X11
    import -window root png:- | xclip -selection clipboard -t image/png
    notify-send "Screenshot" "Full screenshot copied to clipboard"
fi