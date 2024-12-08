{
  lib,
  pkgs,
  namespace,
  config,
  ...
}: {
  options.${namespace}.apps.xsane = {
    enable = lib.mkEnableOption "xsane";
  };

  config = lib.mkIf config.${namespace}.apps.xsane.enable {
    home.packages = [
      pkgs.xsane
    ];
  };
}
