{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    stylixModule.enable = lib.mkEnableOption "Enable Stylix theming";
  };

  config = lib.mkIf config.stylixModule.enable {
    stylix = {
      enable = true;
      autoEnable = true;
      polarity = "dark";

      base16Scheme = "${pkgs.base16-schemes}/share/themes/everforest.yaml";

      image = config.lib.stylix.pixel "base0A";

      cursor = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Ice";
        size = 24;
      };

      fonts = {
        monospace = {
          package = pkgs.fira-code;
          name = "Fira Code";
        };
        sansSerif = {
          package = pkgs.noto-fonts;
          name = "Noto Sans Medium";
        };
        serif = {
          package = pkgs.noto-fonts;
          name = "Noto Serif";
        };
        emoji = {
          package = pkgs.noto-fonts-emoji;
          name = "Noto Emoji";
        };
      };
    };
  };
}
