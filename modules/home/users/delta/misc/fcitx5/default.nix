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
  i18n.inputMethod = {
    enabled = "fcitx5";
  };

  i18n.inputMethod.fcitx5.addons = with pkgs; [
    fcitx5-gtk
    fcitx5-mozc-ut
    fcitx5-bamboo
  ];

  xdg.configFile.fcitx5 = {
    enable = true;
    source = ./fcitx5;
  };
}
