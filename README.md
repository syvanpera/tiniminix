# TiniMiniX

A minimal, reproducible NixOS configuration with Niri, Ghostty, and Zen Browser.

## Structure
- `flake.nix`: Entrypoint and inputs.
- `hosts/`: Host-specific and common system configurations.
- `modules/`: Optional hardware modules (e.g., NVIDIA).
- `home/`: User configuration (Home Manager).
- `disko.nix`: Automated BTRFS partitioning (CachyOS style).

## Usage (One-Command Install)

To install this on a new machine from a NixOS installer:

1. **Format and Install** (Using Disko):
   ```bash
   # Replace `hostname` with `laptop` or `laptop-nvidia`
   # Replace `/dev/nvme0n1` with your actual disk
   sh <(curl -L https://nixos.org/nix/install) --daemon
   nix run github:nix-community/disko#disko-install -- --flake github:syvanpera/tiniminix#laptop --disk main /dev/nvme0n1
   ```

2. **Manual Install** (After partitioning):
   ```bash
   nixos-install --flake github:syvanpera/tiniminix#laptop
   ```

## Hardware
- `laptop`: Generic Intel/AMD configuration.
- `laptop-nvidia`: Same as above + NVIDIA drivers enabled.

## Core Software
- **Compositor**: Niri
- **Terminal**: Ghostty
- **Browser**: Zen Browser
