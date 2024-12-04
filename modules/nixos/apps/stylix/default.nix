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

      cursor = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Original-Ice";
        size = 28;
      };

      fonts = {
        serif = {
          name = "Noto Serif";
          package = pkgs.noto-fonts;
        };
        sansSerif = {
          name = "Noto Sans";
          package = pkgs.noto-fonts;
        };
        monospace = {
          name = "FiraCode Nerd Font";
          package = pkgs.nerd-fonts.fira-code;
        };
        emoji = {
          name = "Noto Emoji";
          package = pkgs.noto-fonts-emoji;
        };
      };
    };
  };
}
