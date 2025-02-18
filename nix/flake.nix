# System opitons https://mynixos.com/ 
{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew }:
  let
    configuration = { pkgs, config, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages =[
        pkgs.neovim
        pkgs.lazygit
        pkgs.ripgrep
        pkgs.nodejs_23
        pkgs.fzf
        pkgs.fd
        pkgs.stow
        pkgs.git
        pkgs.cargo
        pkgs.mkalias
        pkgs.yazi
        pkgs.drive
        pkgs.gh
        pkgs.tmux
        pkgs.nushell
        pkgs.zoxide
        pkgs.starship
        pkgs.arc-browser
        pkgs.aerospace
        pkgs.docker
        pkgs.obsidian
        pkgs.raycast
        pkgs.rust-analyzer
      ];

      fonts.packages = [
        pkgs.nerd-fonts.jetbrains-mono
      ];

      system.defaults = {
        dock = {
          show-recents = false;  # Hides "recent apps" section
          persistent-others = [ ];  # Clears Downloads and other stacks
          autohide  = true;
          largesize = 32;
          persistent-apps = [
            "${pkgs.obsidian}/Applications/Obsidian.app"
            "${pkgs.arc-browser}/Applications/Arc.app"
            "/System/Applications/Mail.app"
            "/System/Applications/Calendar.app"
          ];

          wvous-bl-corner = 1; # Bottom-left corner - No Action
          wvous-br-corner = 1; # Bottom-right corner (default "Show Desktop") - Disabled
          wvous-tr-corner = 1; # Top-right corner (default "Quick Note") - Disabled
          wvous-tl-corner = 1; # Top-left corner - No Action
          mru-spaces = false;  # Prevents macOS from rearranging spaces
          expose-group-apps = true;
          launchanim = false;
        };
        WindowManager = {
          EnableStandardClickToShowDesktop = false;
          StandardHideDesktopIcons = true;
          };

        NSGlobalDomain = {
          _HIHideMenuBar = true;  # Hide top menu bar
          AppleICUForce24HourTime = true;
          KeyRepeat = 2;
        };

        finder.FXPreferredViewStyle = "clmv";
        loginwindow.GuestEnabled  = false;
      };

      homebrew = {
        enable = true;
        brews = [
          # "mas"
        ];
        casks = [
          "ghostty"
          "google-drive"
        ];
        # masApps = {
        # };
        onActivation.cleanup = "zap";
      };

      nixpkgs.config.allowUnfree = true;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Install rosetta
      # system.activationScripts.extraActivation.text = ''
      #   softwareupdate --install-rosetta --agree-to-license
      # '';

      # Enable alternative shell support in nix-darwin.
      # programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 6;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#simple
    darwinConfigurations."m1" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable = true;
            # Apple Silicon Only
            enableRosetta = true;
            # User owning the Homebrew prefix
            user = "dawidpereira";

            autoMigrate = true;
          };
        }
      ];
    };
  };
}
