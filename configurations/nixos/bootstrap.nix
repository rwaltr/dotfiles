{ flake, inputs, ... }:
let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  nixpkgs.hostPlatform = "x86_64-linux";
  imports = [
    "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
    "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/channel.nix"
    self.nixosModules.default
  ];
}
