{
  lib,
  pkgs,
  namespace,
  config,
  ...
}: let
  user = config.snowfallorg.user.name;
in
  lib.${namespace}.mkModule ./. config {
    enable = lib.mkEnableOption "Mindustry";
    wayland = lib.mkEnableOption "Wayland support";
  } {
    home =
      {
        packages =
          lib.${namespace}.mkIfElse
          (config.${namespace}.apps.mindustry.wayland)
          [pkgs.mindustry-wayland]
          [pkgs.mindustry];
      }
      # Persist the game directory if Impermanence is enabled
      // lib.mkIf config.${namespace}.users.${user}.impermanence.enable {
        persistence."/persist/${user}" = {
          directories = [
            ".local/share/Mindustry"
          ];
        };
      };
  }
