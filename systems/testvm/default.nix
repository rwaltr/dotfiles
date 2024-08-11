{ pkgs, flake, ... }:
let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware.nix
    ../../nixos/users/rwaltr.nix
    inputs.disko.nixosModules.default
    self.nixosModules.common
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

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

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
