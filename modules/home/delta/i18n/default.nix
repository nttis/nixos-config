{
  lib,
  pkgs,
  ...
}:
{
  imports = [ ];

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";

    fcitx5 = {
      addons = with pkgs; [
        fcitx5-bamboo
        fcitx5-gtk
        fcitx5-mozc-ut
      ];
      waylandFrontend = true;
    };
  };

  xdg.configFile."fcitx5" = lib.mkForce {
    enable = true;
    source = ./fcitx5;
  };
}
