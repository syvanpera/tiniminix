# TiniMiniX

My NixOS environment configuration.

> **WARNING**
The default installer *WILL* erase your whole disk and install NixOS on it

## Features

- 🗂️ **BTRFS Filesystem:** Modern copy-on-write filesystem with:
  - Transparent compression (zstd)
  - Multiple subvolumes for flexible management
- 🚀 **Modern Bootloader:** Limine by default
- 🎯 **Multi-Machine Support:** Easy configuration management for multiple machines
- 📦 **Flake-Based:** Reproducible builds with Nix flakes
- 🔧 **Disko Integration:** Automated disk partitioning and formatting

## Quick Start

1. Boot from a NixOS USB drive
2. Clone this repository:
   ```bash
   git clone https://github.com/syvanpera/tiniminix
   cd tiniminix
   ```
4. Run the installation:
   ```bash
   ./install.sh <hostname> <disk>
   # For example:
   ./install.sh tuxedo /dev/nvme0n1
   ```

For more detailed instructions, see [INSTALL.md](INSTALL.md).

## Repository Structure

```
.
├── flake.nix                          # Main flake configuration
├── modules/
│   ├── common.nix                     # Shared configuration across all machines
│   ├── disko.nix                      # Disko configuration
│   └── nvidia.nix                     # NVidia GPU module
└── hosts/
    └── tuxedo.nix                     # Host-specific configuration
```

## Disk Layout

The default disk layout uses:

- **ESP (1024MB):** EFI System Partition mounted at `/boot`
- **Main Partition:** Contains BTRFS filesystem with subvolumes:
  - `@` - Root filesystem (`/`)
  - `@home` - Home directories (`/home`)
  - `@nix` - Nix store (`/nix`)
  - `@log` - System logs (`/var/log`)
  - `@cache` - System cache (`/var/cache`)
  - `@tmp` - Persisted temporary files (`/var/tmp`)
  - `@srv` - Service data (`/srv`)

All subvolumes use zstd compression and are optimized for SSD with `noatime`.

## Adding a New Machine

1. Create machine directory:
  ```bash
  mkdir -p machines/my-machine
  ```

2. Create machine configuration:
  ```bash
  cp machines/example-machine/configuration.nix machines/my-machine/
  nano machines/my-machine/configuration.nix
  nixos-generate-config --no-filesystems --show-hardware-config > machines/my-machine/hardware-config.nix
  ```

2. Add to `flake.nix`:
  ```nix
  nixosConfigurations = {
    my-machine = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./modules/disko.nix
        ./modules/common.nix
        ./modules/users.nix
        ./machines/my-machine/configuration.nix
      ];
    };
  };
  ```

## System Updates

```bash
# Update flake inputs
nix flake update

# Rebuild system
sudo nixos-rebuild switch --flake .#hostname
```

## Documentation

- [Installation Guide](INSTALL.md) - Complete installation instructions
- [Quick Reference](REFERENCE.md) - Common commands and operations
- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- [Disko](https://github.com/nix-community/disko) - Disk configuration tool

## License

This configuration is provided as-is for personal use. Feel free to fork and modify.

