{ config, pkgs, lib, ... }:

{
  # Common configuration shared across all machines

  # Bootloader configuration
  boot.loader = {
    limine = {
      enable = true;
      efiSupport = true;
    };
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
  };

  # Nix settings
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
  };

  nixpkgs.config.allowUnfree = true;

  # Networking
  networking = {
    networkmanager.enable = true;
  };

  # Time zone and locale
  time.timeZone = lib.mkDefault "Europe/Helsinki";
  i18n = {
    defaultLocale = lib.mkDefault "en_US.UTF-8";
    extraLocaleSettings = let fi = "fi_FI.UTF-8"; in {
      LC_ADDRESS = fi;
      LC_IDENTIFICATION = fi;
      LC_MEASUREMENT = fi;
      LC_MONETARY = fi;
      LC_NAME = fi;
      LC_NUMERIC = fi;
      LC_PAPER = fi;
      LC_TELEPHONE = fi;
      LC_TIME = fi;
    };
  };

  # Console configuration
  console = {
    font = "Lat2-Terminus16";
    keyMap = lib.mkDefault "fi";
  };

  # System packages available system-wide
  environment.systemPackages = with pkgs; [
    # Basic utilities
    wget
    curl
    git

    # Disk utilities
    parted
    btrfs-progs
  ];

  # Allow adding users via the normal useradd/groupadd commands
  # users.mutableUsers = true;

  # System state version
  # This should be set to the NixOS version you first installed
  system.stateVersion = "25.11";
}
