#!/usr/bin/env python3
import json
import sys
import subprocess
import os
from datetime import datetime

SOUND_MAP = {
    "task_complete": "/System/Library/Sounds/Glass.aiff",
    "attention_needed": "/System/Library/Sounds/Ping.aiff",
    "security_blocked": "/System/Library/Sounds/Sosumi.aiff",
    "error": "/System/Library/Sounds/Basso.aiff",
}

def play_sound(sound_name):
    sound_file = SOUND_MAP.get(sound_name)
    if sound_file and os.path.exists(sound_file):
        subprocess.run(['afplay', sound_file], capture_output=True, check=False)

def send_notification(title, message, subtitle="", sound_name=None):
    try:
        message = message.replace('"', '\\"')
        title = title.replace('"', '\\"')
        subtitle = subtitle.replace('"', '\\"')
        
        if subtitle:
            script = f'display notification "{message}" with title "{title}" subtitle "{subtitle}"'
        else:
            script = f'display notification "{message}" with title "{title}"'
        
        subprocess.run(['osascript', '-e', script], capture_output=True, text=True, check=False)
        
        if sound_name:
            play_sound(sound_name)
            
    except Exception:
        pass

def main():
    try:
        raw_input = sys.stdin.read()
        if not raw_input.strip():
            return
        
        data = json.loads(raw_input)
        hook_event = data.get('hook_event_name', '')
        
        if hook_event == 'Stop':
            timestamp = datetime.now().strftime("%H:%M:%S")
            send_notification(
                "Claude Code Complete",
                "Task finished successfully",
                f"Completed at {timestamp}",
                "task_complete"
            )
        elif hook_event == 'Notification':
            notification_text = data.get('notification', '')
            timestamp = datetime.now().strftime("%H:%M:%S")
            
            if "permission" in notification_text.lower() or "idle" in notification_text.lower():
                sound = "attention_needed"
            else:
                sound = "attention_needed"
            
            send_notification(
                "Claude Code Alert",
                notification_text,
                f"At {timestamp}",
                sound
            )
            
    except Exception:
        pass
    
    sys.exit(0)

if __name__ == "__main__":
    main()