{ config, lib, ... }:

{
  imports = [
    ../modules/nvidia.nix
  ];

  networking.hostName = "tuxedo";

  # Early boot configuration
  boot.initrd = {
    # Available kernel modules in initrd
    availableKernelModules = [
      "xhci_pci"
      "thunderbolt"
      "nvme"
      "usb_storage"
      "sd_mod"
    ];

    # Kernel modules to load in initrd
    kernelModules = [
      "kvm-intel"
      "btrfs"
    ];
  };

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
