{ self, inputs, config, ... }:
{
  flake = {
    nixosModules = {
      common.imports = [
        ./self/primary-as-admin.nix
      ];

      my-home = {
        users.users.${config.people.myself}.isNormalUser = true;

        home-manager.users.${config.people.myself} = {
          imports = [
            self.homeModules.common-linux
          ];
        };
      };

      default.imports = [
        self.nixosModules.home-manager
        self.nixosModules.my-home
        self.nixosModules.common
        inputs.ragenix.nixosModules.default
      ];
    };
  };
}
