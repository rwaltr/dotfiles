{ self, inputs, ... }:
{
  flake = {
    homeModules = {
      common = {
        imports = [
          {
            home.stateVersion = "22.11";
          }
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
