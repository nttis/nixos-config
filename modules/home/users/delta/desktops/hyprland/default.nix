{
  lib,
  config,
  pkgs,
  namespace,
  ...
}:
lib.${namespace}.mkModule ./. config {
  enable = lib.mkEnableOption "user-specific Hyperland config";
} {
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "SUPER";

      general = {
        gaps_in = 2.5;
        gaps_out = 5;

        border_size = 2;
        resize_on_border = true;

        layout = "dwindle";
      };

      animations = {
        enabled = true;
        animation = [
          "global, 1, 1, default"
        ];
      };

      input = {
        touchpad = {
          natural_scroll = true;
        };
      };

      bind = [
        "$mod, RETURN, exec, ${pkgs.ghostty}/bin/ghostty"
        "$mod, R, exec, ${pkgs.rofi-wayland}/bin/rofi -show combi -combi-modes run,drun"

        "$mod, C, killactive, "
        "$mod, M, exit, "

        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"

        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"

        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"
      ];

      bindel = [
        ",XF86MonBrightnessUp, exec, ${pkgs.brightnessctl}/bin/brightnessctl s 5%+"
        ",XF86MonBrightnessDown, exec, ${pkgs.brightnessctl}/bin/brightnessctl s 5%-"
      ];
    };
  };

  programs.waybar = {
    enable = true;
    systemd.enable = true;
  };

  services.mako = {
    enable = true;
    defaultTimeout = 10000;
  };

  systemd.user.services.oneshot = {
    Unit = {
      Description = "Oneshot service for miscellaneous things";
      After = ["graphical-session.target"];
    };

    Service = {
      Type = "oneshot";
      ExecStart = ''
        ${pkgs.brightnessctl}/bin/brightnessctl set 70%
      '';
    };

    Install = {
      WantedBy = ["graphical-session.target"];
    };
  };
}
