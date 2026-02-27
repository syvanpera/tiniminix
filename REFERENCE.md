# Quick Reference Guide

## Common Commands

### System Management

```bash
# Rebuild system with current configuration
sudo nixos-rebuild switch --flake .#hostname

# Test configuration without switching
sudo nixos-rebuild test --flake .#hostname

# Build configuration without activating
sudo nixos-rebuild build --flake .#hostname

# Update flake inputs
nix flake update

# Show what would be updated
nix flake update --dry-run

# Show system configuration
nixos-option system.stateVersion
```

### Disk Management

```bash
# Check BTRFS filesystem
sudo btrfs filesystem show
sudo btrfs filesystem df /

# Check BTRFS usage by subvolume
sudo btrfs subvolume list /

# Manual scrub
sudo btrfs scrub start /
sudo btrfs scrub status /

# Defragment (rarely needed with BTRFS)
sudo btrfs filesystem defragment -r /
```

### Boot Management

```bash
# List available generations
sudo nix-env --list-generations --profile /nix/var/nix/profiles/system

# Rollback to previous generation
sudo nixos-rebuild switch --rollback

# Switch to specific generation
sudo /nix/var/nix/profiles/system-<number>-link/bin/switch-to-configuration switch
```

### Package Management

```bash
# Search for packages
nix search nixpkgs <package-name>

# Run package without installing
nix run nixpkgs#<package-name>

# Install package temporarily
nix-shell -p <package-name>

# Show package info
nix search nixpkgs <package-name> --json
```

### System Information

```bash
# Show system information
nixos-version
nix-info

# Show disk usage
df -h
sudo btrfs filesystem df /

# Show subvolumes
sudo btrfs subvolume list /
```

## Recovery Procedures

### Boot into Recovery Mode

1. Reboot system
2. At Limine menu, select an older generation
3. System will boot with previous configuration
