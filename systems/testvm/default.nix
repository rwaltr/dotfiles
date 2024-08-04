{
  # Snowfall Lib provides a customized `lib` instance withr access to your flake's library
  # as well as the libraries available from your flake's inputs.
  # An instance of `pkgs` with your overlays and packages applied is also available.
  pkgs
, # You also have access to your flake's inputs.
  # Additional metadata is provided by Snowfall Lib.
  system
, # The system architecture for this host (eg. `x86_64-linux`).
  # The Snowfall Lib target for this system (eg. `x86_64-iso`).
  # A normalized name for the system target (eg. `iso`).
  # A boolean to determine whether this system is a virtual target using nixos-generators.
  # An attribute map of your defined hosts.
  # All other arguments come from the system system.
  config
, inputs
, ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware.nix
  ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";
  boot.loader.grub.useOSProber = true;
  # sops.age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
  # sops.secrets.luksCreds = {
  #   sopsFile = ../../../secrets/testsecrets.yaml;
  # };

  disko.devices = import ../../nixos/disko/luks-brtfs-persist.nix {
    device = "/dev/vda";
    luksCreds = config.sops.secrets.luksCreds.path;
  };


  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

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

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound with pipewire.
  # sound.enable = true;
  # hardware.pulseaudio.enable = false;
  # security.rtkit.enable = true;
  # services.pipewire = {
  # enable = true;
  # alsa.enable = true;
  # alsa.support32Bit = true;
  # pulse.enable = true;
  # If you want to use JACK applications, uncomment this
  #jack.enable = true;

  # use the example session manager (no others are packaged yet so this is enabled by default,
  # no need to redefine it in your config for now)
  #media-session.enable = true;
  # };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.users.rwaltr = {
  #   isNormalUser = true;
  #   description = "Ryan Walter";
  #   extraGroups = [ "networkmanager" "wheel" ];
  #   packages = with pkgs; [
  #     chezmoi
  #     yq
  #     jq
  #     neovim
  #     git
  #     kubectl
  #   ];
  # };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    neovim
    vim
    git
    nano
    curl
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 22 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
