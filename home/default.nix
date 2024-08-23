{ self, inputs, ... }:
{
  flake = {
    homeModules = {
      common = {
        home.stateVersion = "22.11";
        imports = [
          ./nix.nix
        ];
      };
      common-linux = {
        imports = [
          self.homeModules.common
          # ./hyprland.nix
        ];
      };
      common-darwin = {
        imports = [
          self.homeModules.common
        ];
      };
    };
  };
}
