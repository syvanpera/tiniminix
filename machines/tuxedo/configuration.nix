{ config, lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nvidia.nix
  ];

  networking.hostName = "tuxedo";
}
