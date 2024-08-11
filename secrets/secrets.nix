let
  config = import ../users/config.nix;
  users = [ config.users.rwaltr.sshKeys ];

  nomadix = "CHANGE";
  systems = [ nomadix ];
in
{
  "nomadix.env.age".publicKeys = users ++ systems;
}
