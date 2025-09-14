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
    wl-clipboard
    rofi
    xwayland-satellite
  ];
}
