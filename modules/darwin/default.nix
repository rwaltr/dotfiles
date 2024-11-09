# Configuration common to all macOS systems
{ flake, ... }:
let
  inherit (flake) config inputs;
  inherit (inputs) self;
in
{
  imports = [
    {
      # For home-manager to work.
      users.users.${config.me.username} = {
        home = "/Users/${config.me.username}";
      };
      home-manager.users.${config.me.username} = { };
      home-manager.sharedModules = [
        self.homeModules.default
        self.homeModules.darwin-only
      ];
    }
    self.nixosModules.common
    inputs.ragenix.darwinModules.default
  ];

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
}
