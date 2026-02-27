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
    pciutils

    # Disk utilities
    parted
    btrfs-progs
  ];

  users.mutableUsers = true;

  ## TODO: This doesn't currently work because the network isn't up when the service runs during the first boot
  # Clone this config to the target machine on first boot.
  # systemd.services.bootstrap-nix-config = {
  #   description = "Bootstrap local NixOS config checkout";
  #   wantedBy = [ "multi-user.target" ];
  #   after = [ "network-online.target" ];
  #   wants = [ "network-online.target" ];
  #
  #   serviceConfig = {
  #     Type = "oneshot";
  #     User = "tuomo";
  #     Group = "users";
  #     WorkingDirectory = "/home/tuomo";
  #   };
  #
  #   script = ''
  #     if [ ! -d /home/tuomo/.config/tiniminix/.git ]; then
  #       ${pkgs.git}/bin/git clone https://github.com/syvanpera/tiniminix.git /home/tuomo/.config/tiniminix
  #     fi
  #   '';
  # };

  # System state version
  # This should be set to the NixOS version you first installed
  system.stateVersion = "25.11";
}
