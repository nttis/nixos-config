{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
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
    // lib.mkIf config.${namespace}.impermanence.enable {
      persistence."/persist/${config.snowfallorg.user.name}" = {
        directories = [
          ".local/share/Mindustry"
        ];
      };
    };
}
