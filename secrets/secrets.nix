let
  config = import ../users/config.nix;
  rwaltrkeys = config.users.rwaltr.sshKeys;

  nomadix = "CHANGE";
  monolith = "CHANGE";
  systems = [ ];
in
{
  "nomadix.env.age".publicKeys = rwaltrkeys;
  "monolith.env.age".publicKeys = rwaltrkeys;
  "lukskey.age".publicKeys = rwaltrkeys;
}
