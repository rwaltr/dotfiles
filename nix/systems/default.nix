{ inputs, ... }:
{
  flake.nixosConfigutions =
    let
      inherit (inputs.nixpkgs.lib) nixosSystem;
    in
    {
      # testvm = import ./x86_64-linux/testvm;
    };
}
