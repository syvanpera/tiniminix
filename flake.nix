{
  description = "TiniMiniX - NixOS environment with BTRFS and Limine bootloader";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # home-manager = {
    #   url = "github:nix-community/home-manager";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations = {
      tuxedo = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./modules/disko.nix
          ./modules/common.nix
          # ./modules/home-manager.nix
          ./modules/users.nix
          ./machines/tuxedo/configuration.nix
        ];
      };
    };
  };
}
