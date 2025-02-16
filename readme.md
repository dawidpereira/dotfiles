# My dotfiles

This directory contains the dotfiles for my system

## Requirements

Ensure you have the following installed on your system

- Git

## Installation

First, check out the dotfiles repo in your `$HOME/dotfiles` directory using git

```bash
$ git clone https://github.com/dawidpereira/dotfiles.git ~/dotfiles
```

### Set up Nix

Then instal and rebuild [Nix setup](https://nixos.org/download/)

```bash
darwin-rebuild switch --flake ~/dotfiles/nix#m1
```

### Install TPM

Unfortunately there is no easy way to automatically instal TPM from Nix flake configuration.
The easiest way is to do it manually according to [TPM Documentation](https://github.com/tmux-plugins/tpm)

### Set up symlinks

Finally use GNU stow to create symlinks

```bash
cd ~/dotfiles
```

```bash
$ bash build_symlinks.sh
```
