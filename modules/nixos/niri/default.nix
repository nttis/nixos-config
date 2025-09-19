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

    gnome.gnome-keyring.enable = false;
  };

  environment.systemPackages = with pkgs; [
    nautilus
    wl-clipboard
    rofi
    xwayland-satellite
  ];
}
