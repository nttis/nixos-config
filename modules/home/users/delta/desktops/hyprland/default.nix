{
  inputs,
  lib,
  config,
  pkgs,
  system,
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

        border_size = 1;
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
        # Terminal
        "$mod, RETURN, exec, ${lib.getExe pkgs.kitty}"

        # Rofi
        "$mod, R, exec, ${lib.getExe pkgs.rofi-wayland} -show combi -combi-modes run,drun"

        # Screenshotting
        ", PRINT, exec, ${lib.getExe pkgs.hyprshot} --mode region --clipboard-only"
        "$mod, PRINT, exec, ${lib.getExe pkgs.hyprshot} --mode active --mode window --clipboard-only"

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

        ",XF86AudioRaiseVolume, exec, ${pkgs.wireplumber}/bin/wpctl set-volume -l 2 @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ];

      env = [
        "XCURSOR_THEME,Bibata-Original-Ice"
      ];
    };
  };

  services.mako = {
    enable = true;
    defaultTimeout = 10000;
  };

  services.swayosd = {
    enable = true;
  };

  # TODO: perhaps extract this to its own separate module
  systemd.user.services.ashell = {
    Unit = {
      Description = "ashell";
      After = ["graphical-session.target"];
    };

    Service = {
      Type = "simple";
      ExecStart = "${inputs.ashell.defaultPackage.${system}}/bin/ashell";
      Restart = "always";
    };

    Install = {
      WantedBy = ["graphical-session.target"];
    };
  };

  xdg.configFile."ashell.yml" = {
    enable = true;
    text =
      /*
      yaml
      */
      ''
        position: Top

        modules:
          left:
            - AppLauncher
            - Workspaces
          center:
            - [WindowTitle, MediaPlayer]
          right:
            - Tray
            - SystemInfo
            - [Clock, Privacy, Settings]

        settings:
          audioSinksMoreCmd: "${pkgs.pavucontrol}/bin/pavucontrol -t 3"
          audioSourcesMoreCmd: "${pkgs.pavucontrol}/bin/pavucontrol -t 4"

        appLauncherCmd: "${pkgs.rofi-wayland}/bin/rofi -show drun"

        truncateTitleAfterLength: 50

        mediaPlayer:
          maxTitleLength: 50
      '';
  };

  gtk = {
    enable = true;

    cursorTheme = {
      package = lib.mkDefault pkgs.bibata-cursors;
      name = lib.mkDefault "Bibata-Original-Ice";
    };
  };

  qt = lib.mkDefault {
    enable = true;
    style.name = "adwaita";
  };
}
