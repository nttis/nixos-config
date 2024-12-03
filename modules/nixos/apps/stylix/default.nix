{
  lib,
  config,
  pkgs,
  namespace,
  ...
}: {
  options.${namespace}.apps.stylix = {
    enable = lib.mkEnableOption "Stylix automatic theming";
  };

  config = lib.mkIf config.${namespace}.apps.stylix.enable {
    stylix = {
      enable = true;

      polarity = "dark";
      base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";

      image = ./assets/LoneTrail.png;
    };
  };
}
