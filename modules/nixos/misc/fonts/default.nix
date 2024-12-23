{
  lib,
  config,
  pkgs,
  namespace,
  ...
}:
lib.${namespace}.mkModule ./. config {
  enable = lib.mkEnableOption "font management";
} {
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

      nerd-fonts.fira-code

      font-awesome
    ];

    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = ["Noto Serif"];
        sansSerif = ["Noto Sans"];
        monospace = ["FiraCode Nerd Font"];
        emoji = ["Noto Emoji" "Noto Color Emoji"];
      };
    };
  };
}
