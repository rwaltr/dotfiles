{ flake, ... }:
let
  inherit (flake.inpurts) self;
  inherit (flake.config) me;
in
{

  imports = [
    self.homeModules.default
    self.homeModules.linux-only
  ];
  home.username = me.username;
  home.homeDirectory = "/home${me.username}";
}

