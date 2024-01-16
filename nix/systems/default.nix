{ inputs, ... }:
{
  flake.nixosConfigurations =
    let
      inherit (inputs.nixpkgs.lib) nixosSystem;
    in
    {
      iso = nixosSystem {
        system = "x86_64-linux";
        modules = [
          "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
          "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/channel.nix"
          ({ ... }: {
            nix.settings.experimental-features = [ "nix-command" "flakes" ];
          })
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
          ./nomadix
        ];
      };

    };
}
