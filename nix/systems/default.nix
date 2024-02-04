{ inputs, ... }: {
  flake.nixosConfigurations =
    let
      inherit (inputs.nixpkgs.lib) nixosSystem;
    in
    {
      bootstrap = nixosSystem {
        system = "x86_64-linux";
        modules = [
          "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
          "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/channel.nix"
          ./bootstrap
        ];
      };
      testvm = nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./testvm
        ];
      };
      nomadix = nixosSystem {
        system = "x86_64-linux";
        modules = [
          inputs.hardware.nixosModules.framework-13-7040-amd
          ./nomadix
        ];
      };
    };
}
