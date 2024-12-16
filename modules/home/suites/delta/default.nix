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
  }
