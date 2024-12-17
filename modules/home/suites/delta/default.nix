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
      suites = {
        common.enable = true;
      };

      apps = {
        git = {
          enable = true;

          userName = "nttis";
          userEmail = "42465069+nttis@users.noreply.github.com";
        };
      };

      impermanence.enable = true;
    };

    programs.helix = {
      settings = {
        editor.cursor-shape = {
          insert = "bar";
          normal = "bar";
          select = "underline";
        };
      };
    };

    xfconf.settings = {
      "xfce4-terminal" = {
        "misc-cursor-blinks" = true;
        "misc-cursor-shape" = "TERMINAL_CURSOR_SHAPE_IBEAM";
        "scrolling-unlimited" = true;
        "title-mode" = "TERMINAL_TITLE_REPLACE";
      };

      "thunar" = {
        "last-show-hidden" = true;
      };
    };
  }
