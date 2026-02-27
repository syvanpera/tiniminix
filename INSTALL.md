# Installation Guide

This guide will help you install NixOS from a USB drive using this flake configuration.

## Prerequisites

1. A NixOS installation USB drive (download minimal image from https://nixos.org/download.html)
2. A target machine with UEFI support
3. Internet connection
4. Basic knowledge of Linux command line

## Installation Steps

### 1. Boot from USB Drive

Boot your machine from the NixOS USB drive. You should see the NixOS boot menu.

### 2. Connect to the Internet

If using WiFi:
```bash
nmcli radio wifi on
nmcli dev wifi
# This will ask you for the password
nmcli dev wifi connect "SSID" --ask
```

Test internet connection:
```bash
ping -c 3 nixos.org
```

### 3. Clone This Repository

```bash
# Install git if not available
nix-shell -p git

# Clone the repository
git clone https://github.com/syvanpera/tiniminix
cd tiniminix
```

### 4. Run the Installation

```bash
# Replace `hostname` with any of the supported host names (found in `hosts` folder)
# Replace `/dev/nvme0n1` with your actual disk
sudo nix --extra-experimental-features "nix-command flakes" run github:nix-community/disko#disko-install -- --flake github:syvanpera/tiniminix#hostname --disk main /dev/nvme0n1
```

Use the installation helper from the flake:

```bash
# Replace 'example-machine' with your machine name
# Replace '/dev/sda' with your target disk
nix run .#install-system -- example-machine /dev/sda
```

Or manually run the installation steps:

```bash
# 1. Partition and format the disk with disko
sudo nix run github:nix-community/disko -- --mode disko \
  --flake .#example-machine

# 2. Generate hardware configuration
sudo nixos-generate-config --no-filesystems --root /mnt

# 3. Copy the hardware configuration to your machine directory
sudo cp /mnt/etc/nixos/hardware-configuration.nix \
  machines/example-machine/

# 4. Update your configuration to import the hardware config
# Add this line to machines/example-machine/configuration.nix:
# imports = [ ./hardware-configuration.nix ];

# 5. Install NixOS
sudo nixos-install --flake .#example-machine --no-root-passwd

# 6. Set root password
sudo nixos-enter --root /mnt -c 'passwd'
```

### 8. Post-Installation

After installation completes:

1. Remove the USB drive
2. Reboot the system:
   ```bash
   reboot
   ```
3. You'll be prompted to enter your LUKS password
4. Log in with your user account or root
5. Set up user passwords if not done during installation:
   ```bash
   sudo passwd username
   ```

## Managing Your System

### Updating the System

```bash
# Update flake inputs
nix flake update

# Rebuild and switch to new configuration
sudo nixos-rebuild switch --flake .#hostname
```

