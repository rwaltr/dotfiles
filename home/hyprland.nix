{ pkgs, ... }: {
  # wayland.windowManager.hyprland.enable = true;
  # wayland.windowManager.hyprland.systemd.enable = true;
  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    xwayland.enable = true;
    systemd.enable = true;
    settings = {
      # vars and settings
      "$mod" = "SUPER";
      "$terminal" = "wezterm";
      "$menu" = "wofi --show drun";

      # Monitors
      monitors = ",perferred,auto,auto";

      general = {
        gaps_in = 5;
        gaps_out = 20;
        border_size = 2;
        layout = "dwindle";
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
      };

      dwindle = {
        pseudotile = "yes";
        perserve_split = "yes";
      };

      decoration = {
        rounding = 10;
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
        };
        drop_shadow = "yes";
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";
      };

      animations = {
        enabled = "yes";
      };

      master = {
        new_is_master = true;
      };

      bind = [
        "$mod, Space, exec, $menu"
        "$mod, Enter, exec, $terminal"
        "$mod, Q, killactive"
        "$mod, E, exit"
      ];

      bindm = [
        "$mod, mouse272, movewindow"
        "$mod, mouse273, resizewindow"
      ];
    };

  };
}
