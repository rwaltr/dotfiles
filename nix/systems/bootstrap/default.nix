{ inputs, pkgs, ... }:
{
  # import = [
  # ];

  # boot.kernelPackages = pkgs.linuxPackages_latest;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  services.openssh.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 ];
}
