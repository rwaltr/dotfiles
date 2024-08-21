{ pkgs, ... }: {

  imports = [
    ./sddm.nix
  ];
  programs.sway.enable = true;
  services.pipewire.enable = true;
  services.pipewire.pulse.enable = true;
  # programs.waybar.enable = true;

  # This is defaults for the desktop that assume no user config
  environment.systemPackages = with pkgs;[
    # wofi
    dmenu
    firefox-wayland
    # wezterm
    # networkmanagerapplet
  ];
}
