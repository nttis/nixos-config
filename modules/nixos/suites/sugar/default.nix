{
  lib,
  config,
  namespace,
  ...
}: {
  options.${namespace}.suites.sugar = {
    enable = lib.mkEnableOption "theming and aesthetics-related configurations";
  };

  config = lib.mkIf config.${namespace}.suites.sugar.enable {
    anima = {
      apps = {
        stylix.enable = true;
      };

      misc = {
        fonts.enable = true;
      };
    };
  };
}
