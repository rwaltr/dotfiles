# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../../modules/nixos/default.nix
      ../../../modules/nixos/linux/networkmanager.nix
      ../../../modules/nixos/linux/gui/login-manager/sddm.nix
      ../../../modules/nixos/linux/gui/desktops/kde.nix
      ../../../modules/nixos/linux/cli/fish.nix
      ../../../modules/nixos/linux/services/syncthing.nix
      ../../../modules/nixos/linux/services/tailscale.nix
      ../../../modules/nixos/linux/tpm2.nix
      ../../../modules/nixos/linux/fwupd.nix
      ../../../modules/nixos/linux/gui/programs/steam.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.resumeDevice = "/dev/disk/by-uuid/35acc1f4-61a4-447a-9fb3-aa35ab1dbcd9";
  boot.kernelParams = [ "resume_offset=1953695" ];
  boot.initrd.kernelModules = [ "tpm_crb" ];
  hardware.enableAllFirmware = true;

  networking.hostName = "nomadix"; # Define your hostname.

  zramSwap = { enable = true; memoryPercent = 20; };

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;
  services.pipewire.enable = true;
  services.pipewire.pulse.enable = true;


  users.users.rwaltr = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.fish;
  };

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
    #   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    discord
    age
    croc
    curl
    gh
    git
    neovim
    rclone
    restic
    wget
    mpv
    podman
    gcc
    ripgrep
    _1password-gui
    fd
    lazygit
    lazydocker
    terraform
    unzip
    go
    firefox

    pulseaudio
    pavucontrol

    # Hyperland
    dunst
    hyprpaper
    xdg-desktop-portal-hyprland
    foot
    wofi
    starship


  ];



  # Battery Life Improvement
  # https://github.com/TechsupportOnHold/Batterylife/blob/main/laptop.nix
  # Better scheduling for CPU cycles - thanks System76!!!
  services.system76-scheduler.settings.cfsProfiles.enable = true;

  # Enable TLP (better than gnomes internal power manager)
  services.tlp = {
    enable = true;
    settings = {
      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
    };
  };

  # Disable GNOMEs power management
  services.power-profiles-daemon.enable = false;

  # Enable powertop
  powerManagement.powertop.enable = true;

  # Enable thermald (only necessary if on Intel CPUs)
  services.thermald.enable = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "23.11"; # Did you read the comment?

}

