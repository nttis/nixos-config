{
  lib,
  pkgs,
  namespace,
  config,
  ...
}: {
  options.${namespace}.apps.mindustry = {
    enable = lib.mkEnableOption "Mindustry";
    wayland = lib.mkEnableOption "Wayland support";
  };

  config = lib.mkIf config.${namespace}.apps.mindustry.enable {
    home.packages =
      lib.${namespace}.mkIfElse
      (config.${namespace}.apps.mindustry.wayland)
      [pkgs.mindustry-wayland]
      [pkgs.mindustry];

    home.persistence."/persist/${config.snowfallorg.user.name}" = {
      directories = [
        ".local/share/Mindustry"
      ];
    };
  };
}
