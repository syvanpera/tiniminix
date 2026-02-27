{ config, lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "example-machine";
}
