{ pkgs, inputs, ... }:

{
  users.users.tuomo = {
    isNormalUser = true;
    description = "Tuomo Syvänperä";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" ];
    initialPassword = "tuomo";
  };
}
