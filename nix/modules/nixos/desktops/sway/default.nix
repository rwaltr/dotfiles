{ pkgs, ... }: {

  programs.sway.enable = true;
  services.pipewire.enable = true;
  services.pipewire.pulse.enable = true;
  programs.waybar.enable = true;

  environment.systemPackages = with pkgs;[
    wofi
    firefox-wayland
    wezterm
    networkmanagerapplet
  ];
}
