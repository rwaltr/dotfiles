{ inputs, self, ... }: {
  flake.nixosConfigurations =
    {
      bootstrap = self.nixos-flake.lib.mkLinuxSystem {
        nixpkgs.hostPlatform = "x86_64-linux";
        imports = [
          "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
          "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/channel.nix"
          self.nixosModules.common
        ];
      };
      nomadix = self.nixos-flake.lib.mkLinuxSystem {
        nixpkgs.hostPlatform = "x86_64-linux";
        imports = [
          inputs.hardware.nixosModules.framework-13-7040-amd
          inputs.disko.nixosModules.default
          self.nixosModules.common
          ./nomadix
        ];
      };
      testvm = self.nixos-flake.lib.mkLinuxSystem
        ./testvm;
      wifetop = self.nixos-flake.lib.mkMacosSystem
        ./wifetop.nix;
    };
}
