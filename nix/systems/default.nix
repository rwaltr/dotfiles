{ inputs, ... }:
{
  flake.nixosConfigurations =
    let
      inherit (inputs.nixpkgs.lib) nixosSystem;
    in
    {
      testvm = nixosSystem {
        modules = [
          ./x86_64-linux/testvm
        ];
      };
    };
}
