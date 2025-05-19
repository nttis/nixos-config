{pkgs, ...}: {
  imports = [];

  stylix = {
    enable = true;
    enableReleaseChecks = false;

    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/onedark.yaml";

    image = null;

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
        name = "0xProto Nerd Font";
        package = pkgs.nerd-fonts._0xproto;
      };
      emoji = {
        name = "Noto Emoji";
        package = pkgs.noto-fonts-emoji;
      };
    };
  };
}
