#!/usr/bin/env python3
import json
import sys
import re
import subprocess
import platform

def is_dangerous_rm_command(command):
    if not command:
        return False
    
    dangerous_patterns = [
        r'\brm\s+(-rf?|-fr?)\s+[/*]',
        r'\brm\s+(-rf?|-fr?)\s+~',
        r'\brm\s+(-rf?|-fr?)\s+\$HOME',
        r'\brm\s+(-rf?|-fr?)\s+\.\.\/',
        r'\brm\s+(-rf?|-fr?)\s+\*',
        r'\bsudo\s+rm\b',
    ]
    
    for pattern in dangerous_patterns:
        if re.search(pattern, command, re.IGNORECASE):
            return True
    return False

def is_env_file_access(file_path, command=""):
    if not file_path and not command:
        return False
    
    if '.env.sample' in str(file_path) or '.env.example' in str(file_path):
        return False
    
    if file_path and '.env' in str(file_path):
        return True
    
    if command and '.env' in command and '.env.sample' not in command:
        return True
    
    return False

def is_dangerous_git_command(command):
    if not command or 'git' not in command:
        return False
    
    dangerous_git_patterns = [
        # ALL push commands - only user should push
        r'\bgit\s+push\b',
        # Hard reset commands that lose history
        r'\bgit\s+reset\s+--hard\s+HEAD~',
        r'\bgit\s+reset\s+--hard\s+[a-f0-9]{6,}',  # reset to specific commit
        r'\bgit\s+reset\s+--hard\s+origin/',
        # Clean commands that delete untracked files
        r'\bgit\s+clean\s+-[dfx]*f',  # force clean
        # Rebase with force
        r'\bgit\s+rebase\s+.*--force',
        # Filter-branch (rewrites history)
        r'\bgit\s+filter-branch',
        # Remove files from all history
        r'\bgit\s+rm\s+.*--cached',
        # Checkout that might lose changes
        r'\bgit\s+checkout\s+--\s+\.',  # discard all changes
        r'\bgit\s+checkout\s+-f',  # force checkout
        # Stash drop/clear
        r'\bgit\s+stash\s+(drop|clear)',
        # Remote operations that could be destructive
        r'\bgit\s+remote\s+rm',
        r'\bgit\s+remote\s+remove',
        # Reflog deletion
        r'\bgit\s+reflog\s+delete',
        r'\bgit\s+reflog\s+expire\s+.*--expire=now',
    ]
    
    for pattern in dangerous_git_patterns:
        if re.search(pattern, command, re.IGNORECASE):
            return True
    return False

def play_alert_sound():
    """Play an alert sound if on macOS, otherwise do nothing."""
    if platform.system() == 'Darwin':
        subprocess.run(['afplay', '/System/Library/Sounds/Sosumi.aiff'], 
                     capture_output=True, check=False)

def has_ai_generated_message(command):
    if 'git commit' not in command:
        return False
    
    ai_patterns = [
        # Generic AI references
        r'generated\s*(by|with)\s*ai',
        r'ai[- ]generated',
        r'created\s*by\s*ai',
        r'written\s*by\s*ai',
        r'claude\s*code\s*generated',
        r'anthropic.*generated',
        # Co-authorship patterns
        r'co-authored-by:\s*claude',
        r'co-authored-by:.*anthropic',
        r'co-authored-by:.*\bai\b',
        r'co-authored-by:.*bot\b',
        r'co-authored-by:.*assistant',
        # Specific Claude patterns
        r'generated\s*with\s*claude\s*code',
        r'🤖.*generated',
        r'generated.*claude\s*code',
        r'claude.*<noreply@',
        # General AI attribution
        r'created\s*with.*\bai\b',
        r'powered\s*by.*\bai\b',
        r'assisted\s*by.*\bai\b',
    ]
    
    for pattern in ai_patterns:
        if re.search(pattern, command, re.IGNORECASE):
            return True
    return False

def main():
    try:
        input_data = json.load(sys.stdin)
        
        tool_name = input_data.get('tool_name', '')
        tool_input = input_data.get('tool_input', {})
        
        command = tool_input.get('command', '')
        file_path = tool_input.get('file_path', '')
        
        if tool_name == 'Bash' and command:
            # Check for dangerous rm commands
            if is_dangerous_rm_command(command):
                print(f"🚨 SECURITY ALERT: Dangerous command blocked", file=sys.stderr)
                print(f"", file=sys.stderr)
                print(f"Blocked command: {command}", file=sys.stderr)
                print(f"", file=sys.stderr)
                print(f"This command could destroy important files or your system.", file=sys.stderr)
                print(f"", file=sys.stderr)
                print(f"⚠️  USER ACTION REQUIRED:", file=sys.stderr)
                print(f"If you want to proceed with this operation:", file=sys.stderr)
                print(f"1. Review the command carefully", file=sys.stderr)
                print(f"2. Run it manually in your terminal if appropriate", file=sys.stderr)
                print(f"3. Let me know when complete so I can continue", file=sys.stderr)
                print(f"", file=sys.stderr)
                print(f"I will wait for your confirmation before proceeding.", file=sys.stderr)
                
                play_alert_sound()
                sys.exit(2)
            
            # Check for dangerous git commands
            if is_dangerous_git_command(command):
                if 'git push' in command:
                    print(f"🚫 GIT PUSH BLOCKED: Only users should push to remote repositories", file=sys.stderr)
                    print(f"", file=sys.stderr)
                    print(f"Blocked command: {command}", file=sys.stderr)
                    print(f"", file=sys.stderr)
                    print(f"For safety reasons, I cannot push code to remote repositories.", file=sys.stderr)
                    print(f"This prevents accidental or unwanted changes to your codebase.", file=sys.stderr)
                else:
                    print(f"⚠️  GIT SAFETY: Potentially destructive git command blocked", file=sys.stderr)
                    print(f"", file=sys.stderr)
                    print(f"Blocked command: {command}", file=sys.stderr)
                    print(f"", file=sys.stderr)
                    print(f"This command could:", file=sys.stderr)
                    print(f"- Permanently lose commits or changes", file=sys.stderr)
                    print(f"- Delete branches or tags", file=sys.stderr)
                    print(f"- Remove files from git history", file=sys.stderr)
                    print(f"- Discard uncommitted work", file=sys.stderr)
                
                print(f"", file=sys.stderr)
                print(f"⚠️  USER ACTION REQUIRED:", file=sys.stderr)
                print(f"Please review and run this command manually if appropriate:", file=sys.stderr)
                print(f"1. Open your terminal", file=sys.stderr)
                print(f"2. Navigate to the repository", file=sys.stderr)
                print(f"3. Run: {command}", file=sys.stderr)
                print(f"4. Let me know when complete", file=sys.stderr)
                print(f"", file=sys.stderr)
                print(f"I will wait for your confirmation before proceeding.", file=sys.stderr)
                
                play_alert_sound()
                sys.exit(2)
            
            # Check for AI-generated commit messages
            if has_ai_generated_message(command):
                print(f"❌ Commit blocked: Remove AI-generated references from commit message", file=sys.stderr)
                print(f"Guidelines:", file=sys.stderr)
                print(f"- Never add 'Generated by AI' to commit messages", file=sys.stderr)
                print(f"- Do NOT include AI co-authorship (e.g., 'Co-Authored-By: Claude')", file=sys.stderr)
                print(f"- Do NOT add any AI attribution or signatures to commits", file=sys.stderr)
                
                play_alert_sound()
                sys.exit(2)
        
        if tool_name in ['Read', 'Edit', 'Write'] and is_env_file_access(file_path):
            print(f"🔒 SECURITY: Access to sensitive file blocked", file=sys.stderr)
            print(f"", file=sys.stderr)
            print(f"Blocked file access: {file_path}", file=sys.stderr)
            print(f"Tool attempted: {tool_name}", file=sys.stderr)
            print(f"", file=sys.stderr)
            print(f"⚠️  USER ACTION REQUIRED:", file=sys.stderr)
            print(f"This file contains sensitive information.", file=sys.stderr)
            print(f"If you need to access this file:", file=sys.stderr)
            print(f"1. Open it manually in your editor", file=sys.stderr)
            print(f"2. Make any necessary changes", file=sys.stderr)
            print(f"3. Let me know when complete", file=sys.stderr)
            print(f"", file=sys.stderr)
            print(f"Tip: Use .env.sample for template files instead.", file=sys.stderr)
            
            play_alert_sound()
            sys.exit(2)
        
        if tool_name == 'Bash' and is_env_file_access("", command):
            print(f"🔒 SECURITY: Command accessing sensitive file blocked", file=sys.stderr)
            print(f"", file=sys.stderr)
            print(f"Blocked command: {command}", file=sys.stderr)
            print(f"", file=sys.stderr)
            print(f"⚠️  USER ACTION REQUIRED:", file=sys.stderr)
            print(f"This command tries to access sensitive environment files.", file=sys.stderr)
            print(f"If you need to run this command:", file=sys.stderr)
            print(f"1. Review it carefully for security implications", file=sys.stderr)
            print(f"2. Run it manually in your terminal", file=sys.stderr)
            print(f"3. Let me know when complete", file=sys.stderr)
            print(f"", file=sys.stderr)
            print(f"I will wait for your confirmation before proceeding.", file=sys.stderr)
            
            play_alert_sound()
            sys.exit(2)
        
    except Exception:
        pass
    
    sys.exit(0)

if __name__ == "__main__":
    main()