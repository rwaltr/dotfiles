{ options, config, pkgs, lib, ... }:

with lib;
with lib.rwaltr;
let
  cfg = config.rwaltr.user;
in
{
  options.rwaltr.user = with types; {
    name = mkOpt str "rwaltr" "The name to use for the user account.";
    fullName = mkOpt str "Ryan Walter" "The full name of the user.";
    email = mkOpt str "rwaltr@rwalt.pro" "The email of the user.";
    initialPassword = mkOpt str "password"
      "The initial password to use when the user is first created.";
    prompt-init = mkBoolOpt true "Whether or not to show an initial message when opening a new shell.";
    extraGroups = mkOpt (listOf str) [ ] "Groups for the user to be assigned.";
    extraOptions = mkOpt attrs { }
      (mdDoc "Extra options passed to `users.users.<name>`.");
  };

    users.users.${cfg.name} = {
      isNormalUser = true;

      inherit (cfg) name initialPassword;

      home = "/home/${cfg.name}";
      group = "users";

      shell = pkgs.zsh;

      # Arbitrary user ID to use for the user. Since I only
      # have a single user on my machines this won't ever collide.
      # However, if you add multiple users you'll need to change this
      # so each user has their own unique uid (or leave it out for the
      # system to select).
      uid = 1000;

      extraGroups = [ ] ++ cfg.extraGroups;
    } // cfg.extraOptions;
}
