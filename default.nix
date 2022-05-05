{ hmUsers, pkgs, config, ... }: {
  home-manager.users = { inherit (hmUsers) rwaltr; };
  users.defaultUserShell = pkgs.fish;
  users.mutableUsers = true;
  users.users.rwaltr = {
    description = "default";
    isNormalUser = true;
    group = "rwaltr";
    uid = 1000;
    extraGroups = [ "wheel" "networkmanager" ];
    hashedPassword = "$6$2vgl2NpY5DtLyJOm$3mbQHdO/ciuXnXyWYS4qKN8i6D.rfb1cqPocoFKk8aRtf.6Ix9Po8ccgVPVpVgbne/Wfd4lCtGBP4Vcsf2nJ4.";
    openssh.authorizedKeys.keys = (builtins.filter builtins.isString (builtins.split "\n" (builtins.readFile (builtins.fetchurl { url = "https://github.com/rwaltr.keys"; sha256 = "1qxp0v963llqj43v680gz683xr0wnn0avabc4nldahmghc1n808f"; } ))));
  };
}
