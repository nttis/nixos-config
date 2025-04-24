{config, ...}: let
  colors = config.lib.stylix.colors.withHashtag;
in {
  imports = [];

  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        height = 30;

        modules-right = ["tray" "privacy" "backlight" "pulseaudio" "network" "battery"];
        modules-center = ["clock"];
        modules-left = ["niri/workspaces" "niri/window"];

        clock = {
          format = "{:%A, %B %d, %Y (%R)}";
          tooltip-format = "<tt>{calendar}</tt>";

          calendar = {
            mode = "year";
            mode-mon-col = 3;
            weeks-pos = "right";
            on-scroll = 1;

            format = {
              months = "<span color='${colors.base09}'><b>{}</b></span>";
              days = "<span color='${colors.base05}'><b>{}</b></span>";
              weeks = "<span color='${colors.base0B}'><b>W{}</b></span>";
              weekdays = "<span color='${colors.base0A}'><b>{}</b></span>";
              today = "<span color='${colors.base0D}'><b><u>{}</u></b></span>";
            };
          };

          actions = {
            on-click = "mode";
          };
        };

        user = {
          format = "{user}";
          icon = true;
        };

        battery = {
          format = "{icon} {capacity}%";
          format-icons = ["" "" "" "" ""];

          tooltip-format = "{timeTo}, {power}W, {cycles} cycles";
        };

        network = {
          format-wifi = "{icon} {essid}";
          format-ethernet = "󰈀 {ipaddr}/{cidr}";
          format-linked = "󰤫  No wifi";
          format-disconnected = "󰤮  Disconnected";

          tooltip-format = "{ifname}, default gateway: {gwaddr}, subnet mask: {netmask}, signal strength: {signalStrength}%, frequency: {frequency}";

          format-icons = ["󰤯" "󰤟" "󰤢" "󰤥" "󰤨"];
        };

        privacy = {
          icon-size = 14;
        };

        pulseaudio = {
          format = "{icon} {volume}%";
          format-muted = "󰝟";
          format-bluetooth = "󰂯{icon} {volume}%";

          format-icons = {
            default = ["󰕿" "󰖀" "󰕾"];
          };
        };

        backlight = {
          format = "{icon} {percent}%";
          format-icons = ["󰪞" "󰪠" "󰪡" "󰪣" "󰪥"];
        };
      };
    };

    style =
      /*
      css
      */
      ''
        #network {
          padding: 0 0.5em 0 0.5em;
        }

        #privacy-item * {
          color: ${colors.base0F};
        }
      '';

    systemd = {
      enable = true;
      target = "graphical-session.target";
    };
  };
}
