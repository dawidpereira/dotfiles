#!/usr/bin/env python3
"""
User prompt submit hook for Claude Code
Plays a subtle sound when user submits a prompt
"""
import json
import sys
import subprocess
import os
from datetime import datetime

def main():
    """Main entry point"""
    try:
        # Read input (though we don't need it for this simple hook)
        _ = sys.stdin.read()
        
        # Play a subtle sound to indicate prompt received
        sound_file = '/System/Library/Sounds/Tink.aiff'
        if os.path.exists(sound_file):
            subprocess.run(['afplay', sound_file], capture_output=True, check=False)
        
        # Log the event
        timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        with open('/tmp/claude-prompts.log', 'a') as f:
            f.write(f"[{timestamp}] User prompt submitted\n")
        
    except:
        pass  # Silently ignore any errors
    
    sys.exit(0)

if __name__ == "__main__":
    main()