{ inputs, ... }:
{

  import = [
    "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
    "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/channel.nix"
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  services.openssh.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 ];
}
