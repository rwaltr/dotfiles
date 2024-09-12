let
  config = import ../users/config.nix;
  rwaltrkeys = config.users.rwaltr.sshKeys;
  nomadix = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICXORW7Z5b7yfupBn+LthYmXuBbRlakAcxdITQ78vvC0";
  monolith = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGAAHmKmky6glEcQijTQsYvl36fcFC3kSeU/sIMsix7m";
  testvm = "";
  systems = [ nomadix monolith ];
in
{
  "lukskey.age".publicKeys = rwaltrkeys ++ systems;
}
