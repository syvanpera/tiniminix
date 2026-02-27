{ pkgs, inputs, ... }:

{
  home.username = "tuomo";
  home.homeDirectory = "/home/tuomo";

  # Basic state version
  home.stateVersion = "25.11";
}
