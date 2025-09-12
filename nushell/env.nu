# Set the correct path for the Nushell config file
$env.NU_CONFIG = "~/.config/nushell/config.nu"

# Set the correct path for the Nushell environment file
$env.NU_ENV = "~/.config/nushell/env.nu"

# Add commonly used binary directories to PATH
$env.PATH = ($env.PATH | append "~/.local/bin")
$env.PATH = ($env.PATH | append "/usr/local/bin")
$env.PATH = ($env.PATH | append "/opt/homebrew/bin") # For macOS users with Homebrew
$env.PATH = ($env.PATH | append "~/.nix-profile/bin")
$env.PATH = ($env.PATH | append "/run/current-system/sw/bin")
$env.PATH = ($env.PATH | append "/nix/var/nix/profiles/default/bin")
$env.PATH = ($env.PATH | append "/usr/local/share/dotnet")
$env.PATH = ($env.PATH | append "~/.dotnet/tools")
$env.PATH = ($env.PATH | append "~/.cargo/bin")

# Set DOTNET_ROOT for Roslyn LSP
$env.DOTNET_ROOT = "/usr/local/share/dotnet"

$env.config.buffer_editor = "nvim"

# Set default editor (change to your preferred editor)
$env.EDITOR = "nvim"

# Define the history file location
$env.HISTORY_FILE = "~/.config/nushell/history.txt"

# Export language and locale settings (optional)
$env.LANG = "en_US.UTF-8"
$env.LC_ALL = "en_US.UTF-8"

$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
mkdir ~/.cache/carapace
carapace _carapace nushell | save --force ~/.cache/carapace/init.nu

zoxide init nushell | save -f ~/.config/nushell/zoxide.nu
