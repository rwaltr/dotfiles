{ pkgs, ... }: {
  programs.hyprland.enable = true;
  programs.waybar.enable = true;
  services.pipewire.enable = true;
  services.pipewire.pulse.enable = true;
}
