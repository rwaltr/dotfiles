{ inputs, self, ... }: {
  flake.nixosConfigurations =
    {
      nomadix = self.nixos-flake.lib.mkLinuxSystem {
        nixpkgs.hostPlatform = "x86_64-linux";
        imports = [
          inputs.hardware.nixosModules.framework-13-7040-amd
          inputs.disko.nixosModules.default
          self.nixosModules.default
          ./nomadix
        ];
      };
    };
}
