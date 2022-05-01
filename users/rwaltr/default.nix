{ hmUsers, pkgs, config, ... }: {
  home-manager.users = { inherit (hmUsers) rwaltr; };
  users.defaultUserShell = pkgs.fish;
  users.users.rwaltr = {
    description = "default";
    isNormalUser = true;
    group = "rwaltr";
    extraGroups = [ "wheel" "networkmanager" ];
    initalPassword = "dank";
  };
}
