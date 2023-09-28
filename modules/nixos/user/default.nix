{ options, config, pkgs, lib, ... }:

with lib;
with lib.rwaltr;
let
  cfg = config.rwaltr.user;
in
{
  options.rwaltr.user = with types; {
    # name = mkOpt str "rwaltr" "The name to use for the user account.";
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

  config = {
    environment.systemPackages = with pkgs; [
      bat
      fd
      lsd
      curl
      wget
      git
      chezmoi
    ];

    programs.fish = enabled;

    users.users.${cfg.name} = {
      isNormalUser = true;
      inherit (cfg) name initialPassword;
      home = "/home/${cfg.name}";
      group = "users";
      shell = pkgs.fish;
      uid = 1000;
      extraGroups = [ ${cfg.name} ] ++ cfg.extraGroups;
    } // cfg.extraOptions;
  };
}
