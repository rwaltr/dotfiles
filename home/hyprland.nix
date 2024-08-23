{ pkgs, ... }: {
  # wayland.windowManager.hyprland.enable = true;
  # wayland.windowManager.hyprland.systemd.enable = true;
  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    xwayland.enable = true;
    systemd.enable = true;
    settings = {

      "$mod" = "SUPER";

    };

  };
}
