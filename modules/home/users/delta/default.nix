{
  lib,
  config,
  pkgs,
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
      users.common = {
        apps = {
          anki.enable = true;
          gitui.enable = true;
        };
      };

      users.${username} = {
        apps = {
          librewolf.enable = true;
          vesktop.enable = true;

          ghostty.enable = true;
          nushell.enable = true;
          yazi.enable = true;

          git.enable = true;
          helix.enable = true;
        };

        desktops = {
          hyprland.enable = true;
        };

        misc = {
          fonts.enable = true;
          fcitx5.enable = true;
        };

        impermanence.enable = true;
      };
    };

    gtk.iconTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };
  }
