{ self, ... }:
{
  flake.modules.homeManager."fcitx5@delta" =
    {
      lib,
      pkgs,
      ...
    }:
    {
      # WM modules set the waylandFrontend on fcitx5 through this module
      imports = [ self.modules.homeManager.fcitx5 ];

      i18n.inputMethod = {
        enable = true;
        type = "fcitx5";

        fcitx5 = {
          addons = with pkgs; [
            fcitx5-bamboo
            fcitx5-gtk
            fcitx5-mozc-ut
          ];
        };
      };

      xdg.configFile."fcitx5" = lib.mkForce {
        enable = true;
        source = ./fcitx5;
      };
    };
}
