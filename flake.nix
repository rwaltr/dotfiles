{
  inputs = {
    # Principle inputs (updated by `nix run .#update`)
    # nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Mac n stuff
    nix-darwin.url = "github:lnl7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    # homedir stuff
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # flake framework
    flake-parts.url = "github:hercules-ci/flake-parts";

    # helper flake
    nixos-flake.url = "github:srid/nixos-flake";

    # formatting
    treefmt-nix.url = "github:numtide/treefmt-nix";

    # Disk managment
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    ragenix.url = "github:yaxitech/ragenix";

    # Hardware specials
    hardware.url = "github:nixos/nixos-hardware";
  };

  outputs = inputs@{ self, ... }:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" ];
      imports = [
        inputs.treefmt-nix.flakeModule
        inputs.nixos-flake.flakeModule
        ./users
        ./home
        ./nixos
        ./nix-darwin
        ./systems
      ];


      perSystem = { self', inputs', pkgs, system, config, ... }: {
        treefmt.config = {
          projectRootFile = "flake.nix";
          programs.nixpkgs-fmt.enable = true;
        };

        packages.default = self'.packages.activate;
        packages.bootiso = self.nixosConfigurations.bootstrap.config.system.build.isoImage;

        nixos-flake = {
          primary-inputs = [
            "nixpkgs"
            "nixpkgs-stable"
            "home-manager"
            "nix-darwin"
            "nixos-flake"
          ];
        };

        devShells.default = pkgs.mkShell {
          inputsFrom = [ config.treefmt.build.devShell ];
          packages = with pkgs; [
            inputs'.ragenix.packages.default
          ];
        };
      };

    };
}
