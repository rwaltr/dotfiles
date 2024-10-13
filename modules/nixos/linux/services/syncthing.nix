{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    syncthing
  ];
}
