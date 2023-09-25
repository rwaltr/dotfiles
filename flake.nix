{
  description = "Your new nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # TODO: Add any other flake you might need
    # hardware.url = "github:nixos/nixos-hardware";

    # Shameless plug: looking for a way to nixify your themes and make
    # everything match nicely? Try nix-colors!
    # nix-colors.url = "github:misterio77/nix-colors";

    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };


  outputs = inputs:
    inputs.snowfall-lib.mkFlake {
      inherit inputs;

      src = ./.;

      snowfall = {
        root = ./nix;
        namespace = "waltr";
        meta = {
          name = "Rwaltr's Flake";
        };
      };
    };

  #   outputs = {
  #     self,
  #     nixpkgs,
  #     home-manager,
  #     ...
  #   } @ inputs: let
  #     inherit (self) outputs;
  #   in {
  #     # NixOS configuration entrypoint
  #     # Available through 'nixos-rebuild --flake .#your-hostname'
  #     nixosConfigurations = {
  #       # FIXME replace with your hostname
  #       testvm = nixpkgs.lib.nixosSystem {
  #         specialArgs = {inherit inputs outputs;};
  #         # > Our main nixos configuration file <
  #         modules = [./nix/nixos/configuration.nix];
  #       };
  #     };
  #
  #     # Standalone home-manager configuration entrypoint
  #     # Available through 'home-manager --flake .#your-username@your-hostname'
  #     homeConfigurations = {
  #       # FIXME replace with your username@hostname
  #       "rwaltr@monolith" = home-manager.lib.homeManagerConfiguration {
  #         pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
  #         extraSpecialArgs = {inherit inputs outputs;};
  #         # > Our main home-manager configuration file <
  #         modules = [./nix/home-manager/home.nix];
  #       };
  #     };
  #   };

}
