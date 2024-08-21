{ pkgs, flake, ... }:
let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  imports = [
    # Include the results of the hardware scan.
    inputs.disko.nixosModules.default
    self.nixosModules.default
    ./hardware.nix
    ../../nixos/users/rwaltr.nix
    ../../nixos/gui/desktops/hyprland.nix
    ../../nixos/users/rwaltr.nix
    ../../nixos/services/syncthing.nix
    ../../nixos/services/tailscale.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # sops.secrets.luksCreds = {
  #   sopsFile = ../../../secrets/testsecrets.yaml;
  # };

  networking.hostName = "testvm"; # Define your hostname.
  disko.devices = import ../../nixos/disko/brtfs-persist.nix {
    device = "/dev/vda";
    # luksCreds = config.sops.secrets.luksCreds.path;
  };

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Chicago";


  environment.systemPackages = with pkgs; [
    wget
    neovim
    vim
    git
    nano
    curl
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
