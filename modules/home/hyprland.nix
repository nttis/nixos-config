{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    hyprland.enable = lib.mkEnableOption "enables Hyprland";
  };

  config = lib.mkIf config.hyprland.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;

      plugins = [
        inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars
      ];

      settings = {
        exec-once = [
          "ags"
        ];

        env = [
          "XCURSOR_SIZE,24"
          "HYPRCURSOR_SIZE,24"
        ];

        cursor = {
          # This singlehandedly fixes all off-center cursor problems
          # god bless
          no_hardware_cursors = true;
        };

        general = {
          gaps_in = 3;
          gaps_out = 10;

          border_size = 2;

          resize_on_border = true;
          layout = "master";
        };

        decoration = {
          rounding = 10;
          blur.enabled = false;
        };

        animations = {
          enabled = false;
        };

        bind = [
          "SUPER, C, killactive"
          "SUPER, Q, exec, kitty"
          "SUPER, R, exec, rofi -show drun"
          "SUPER, V, togglefloating"
        ];

        plugin = {
          hyprbars = {
            bar_height = 20;

            hyprbars-button = [
              "rgb(ff4040), 10, , hyprctl dispatch killactive"
              "rgb(eeee11), 10, , hyprctl dispatch fullscreen 1"
            ];
          };
        };
      };
    };
  };
}
