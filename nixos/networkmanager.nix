{ pkgs, ... }:
{
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
  ];
}
