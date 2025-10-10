{
  ...
}:
{
  flake.modules.nixos.niri =
    {
      pkgs,
      ...
    }:
    {
      programs = {
        niri.enable = true;
      };

      xdg.portal = {
        xdgOpenUsePortal = true;
        config.common = {
          default = [
            "gnome"
            "gtk"
          ];
        };
      };

      services = {
        greetd = {
          enable = true;
          settings = {
            default_session = {
              command = "${pkgs.tuigreet}/bin/tuigreet --time";
              user = "greeter";
            };
          };
        };

        flatpak = {
          enable = true;
        };
      };

      security.soteria.enable = true;

      environment.systemPackages = with pkgs; [
        pinentry-gnome3
        nautilus
        wl-clipboard
        rofi
        xwayland-satellite
      ];
    };

  flake.modules.homeManager.fcitx5 = {
    i18n.inputMethod.fcitx5.waylandFrontend = true;
  };
}
