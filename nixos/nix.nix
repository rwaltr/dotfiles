{ flake, pkgs, ... }:
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
      dates = "weekly";
      options = "--delete-older-than +5";
    };
    settings = {
      experimental-features = [ "nix-command" "flakes" "repl-flake" ];
      warn-dirty = false;
      trusted-users = [ "root" (if pkgs.stdenv.isDarwin then flake.config.people.myself else "@wheel") ];
    };
  };
}
