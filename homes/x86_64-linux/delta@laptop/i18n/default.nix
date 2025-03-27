{pkgs, ...}: {
  imports = [];

  i18n.inputMethod = {
    enabled = "fcitx5";

    fcitx5 = {
      addons = with pkgs; [fcitx5-bamboo fcitx5-gtk fcitx5-mozc-ut];
      waylandFrontend = true;
    };
  };

  xdg.configFile."fcitx5" = {
    enable = true;
    source = ./fcitx5;
  };
}
