{ inputs, ... }:

{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

