{ self, inputs, ... }:
{
  flake = {
    homeModules = {
      common = {
        # home.stateVersion = "24.05";
        imports = [
          # ./nix.nix
        ];
      };
      common-linux = {
        imports = [
          self.homeModules.common
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
