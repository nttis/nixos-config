{
  lib,
  config,
  pkgs,
  namespace,
  ...
}: {
  options.${namespace}.fonts = {
    enable = lib.mkEnableOption "font management";
  };

  config = lib.mkIf config.${namespace}.fonts.enable {
    fonts = {
      enableDefaultPackages = false;
      fontDir.enable = true;

      packages = with pkgs; [
        noto-fonts

        noto-fonts-cjk-sans
        noto-fonts-cjk-serif

        noto-fonts-emoji
        noto-fonts-color-emoji
        noto-fonts-monochrome-emoji

        material-symbols

        nerd-fonts.fira-code
      ];

      fontconfig = {
        enable = true;
        defaultFonts = {
          serif = ["Noto Serif" "Noto Serif CJK JP"];
          sansSerif = ["Noto Sans" "Noto Sans CJK JP"];
          monospace = ["FiraCode Nerd Font"];
          emoji = ["Noto Emoji" "Noto Color Emoji"];
        };
      };
    };
  };
}
