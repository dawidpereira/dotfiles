#!/bin/bash
# Screenshot area selection for Linux/Wayland

# Use grim and slurp for Wayland (Omarchy uses Hyprland)
if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    grim -g "$(slurp)" - | wl-copy
    notify-send "Screenshot" "Area screenshot copied to clipboard"
else
    # Fallback for X11
    import png:- | xclip -selection clipboard -t image/png
    notify-send "Screenshot" "Area screenshot copied to clipboard"
fi