{ inputs, self, ... }: {
  flake.nixosConfigurations =
    {
      bootstrap = self.nixos-flake.lib.mkLinuxSystem {
        nixpkgs.hostPlatform = "x86_64-linux";
        imports = [
          "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
          "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/channel.nix"
          self.nixosModules.common
          ./bootstrap.nix
        ];
      };
      nomadix = self.nixos-flake.lib.mkLinuxSystem {
        nixpkgs.hostPlatform = "x86_64-linux";
        imports = [
          inputs.hardware.nixosModules.framework-13-7040-amd
          ./nomadix
        ];
      };
      testvm = self.nixos-flake.lib.mkLinuxSystem {
        nixpkgs.hostPlatform = "x86_64-linux";
        imports = [
          inputs.disko.nixosModules.default
          self.nixosModules.common
          self.homeModules.common-linux
          ./testvm
        ];
      };
    };
}
