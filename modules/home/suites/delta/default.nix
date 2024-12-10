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
      suites = {
        common.enable = true;
      };

      apps = {
        git = {
          enable = true;

          userName = "N";
          userEmail = "42465069+ofcoursenopewastaken@users.noreply.github.com";

          signing = {
            enable = true;
            signingKey = "${pkgs.writeTextFile {
              name = "signing_key.pub";
              text = builtins.readFile ./signing_key.pub;
            }}";
          };
        };
      };

      impermanence.enable = true;
    };
  }
