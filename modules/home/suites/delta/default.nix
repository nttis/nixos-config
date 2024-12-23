{
  lib,
  config,
  namespace,
  ...
}: let
  username = "delta";
in
  lib.${namespace}.mkModule ./. config {
    enable = lib.mkEnableOption "${username}'s suite";
  } {
    snowfallorg.user.name = username;

    anima = {
      apps = {
        xsane.enable = true;
      };

      misc = {
        fonts.enable = true;
      };

      users.${username} = {
        apps = {
          firefox.enable = true;
          vesktop.enable = true;

          wezterm.enable = true;
          git.enable = true;
          helix.enable = true;
        };

        desktops = {
          quickshell.enable = true;
          hyprland.enable = true;
        };

        misc = {
          fcitx5.enable = true;
          xfconf.enable = true;
        };
      };

      impermanence.enable = true;
    };
  }
