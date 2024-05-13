{
  description = "Rwaltr's Dotfiles";

  inputs = {
    # Nixpkgs and unstable
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Hardware specials
    hardware.url = "github:nixos/nixos-hardware";

    # Generate System Images
    nixos-generators.url = "github:nix-community/nixos-generators";
    nixos-generators.inputs.nixpkgs.follows = "nixpkgs";

    # Disk managment
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    treefmt-nix.url = "github:numtide/treefmt-nix";

    # Secret Management
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    # Talhelper
    # talhelper.url = "github:budimanjojo/talhelper";
    # talhelper.inputs.nixpkgs.follows = "unstable";
  };

  outputs = inputs @ { flake-parts, ... }:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];
      imports = [
        inputs.treefmt-nix.flakeModule
        # ./nix/lib
        # ./nix/modules
        ./nix/hosts
      ];

      perSystem = { pkgs, ... }: {
        devShells.default = pkgs.mkShell {
          name = "minimal";
          packages = with pkgs; [
            nix
            nixos-rebuild
            home-manager
            git
          ];
        };
        treefmt = {
          projectRootFile = "flake.nix";
          programs.alejandra.enable = true;
          programs.deadnix.enable = true;
        };
      };
    };
}
