{
  ...
}:
{
  flake.modules.nixos.niri =
    {
      lib,
      pkgs,
      ...
    }:
    {
      programs = {
        niri.enable = true;
      };

      xdg.portal = {
        xdgOpenUsePortal = true;
        extraPortals = lib.mkForce [ pkgs.xdg-desktop-portal-gnome ];
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
      };

      security.soteria.enable = true;

      environment.systemPackages = with pkgs; [
        pinentry-gnome3
        nautilus
        wl-clipboard
        rofi
        swaylock
        xwayland-satellite
      ];
    };

  flake.modules.homeManager.fcitx5 = {
    i18n.inputMethod.fcitx5.waylandFrontend = true;
  };
}
