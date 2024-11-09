{ flake, pkgs, lib, ... }:
let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowBroken = true;
      allowUnsupportedSystem = true;
    };
  };

  nix = {
    nixPath = [ "nixpkgs=${flake.inputs.nixpkgs}" ]; # Enables use of `nix-shell -p ...` etc
    registry.nixpkgs.flake = flake.inputs.nixpkgs; # Make `nix shell` etc use pinned nixpkgs
    gc = {
      automatic = true;
      options = "--delete-older-than +5";
    };
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      extra-platforms = lib.mkIf pkgs.stdenv.isDarwin "aarch64-darwin x86_64-darwin";
      warn-dirty = false;
      trusted-users = [ "root" (if pkgs.stdenv.isDarwin then flake.config.me.username else "@wheel") ];
    };
  };
}
