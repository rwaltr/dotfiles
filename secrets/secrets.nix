let
  config = import ../users/config.nix;
  users = [ config.users.rwaltr.sshKeys ];

  nomadix = "CHANGE";
  monolith = "CHANGE";
  systems = [ nomadix monolith ];
in
{
  "nomadix.env.age".publicKeys = users ++ systems;
  "monolith.env.age".publicKeys = users ++ systems;
}
