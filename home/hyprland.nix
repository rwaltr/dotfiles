{ pkgs, ... }: {
  # wayland.windowManager.hyprland.enable = true;
  # wayland.windowManager.hyprland.systemd.enable = true;
  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    xwayland.enable = true;
    systemd.enable = true;
    settings = {
      bind = [
        "$mod, Space, exec, wofi"
        "$mod, Enter, exec, wezterm"
        "$mod, Q, killactive"
        "$mod, E, exit"
      ];

      "$mod" = "SUPER";

    };

  };
}
