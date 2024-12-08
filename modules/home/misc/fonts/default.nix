{
  lib,
  config,
  namespace,
  ...
}: {
  options.${namespace}.fonts = {
    enable = lib.mkEnableOption "font management";
  };

  config = lib.mkIf config.${namespace}.fonts.enable {
    fonts.fontconfig.enable = true;
  };
}
