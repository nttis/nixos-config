{
  lib,
  config,
  pkgs,
  namespace,
  ...
}:
lib.${namespace}.mkModule ./. config {
  enable = lib.mkEnableOption "user-specific fcitx5 config";
} {
  anima = {
    misc = {
      fcitx5.enable = true;
    };
  };

  i18n.inputMethod.fcitx5.addons = with pkgs; [
    fcitx5-mozc
    fcitx5-bamboo
  ];

  xdg.configFile.fcitx5 = {
    enable = true;
    source = ./fcitx5;
  };
}
