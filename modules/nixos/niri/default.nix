{
  flake,
  pkgs,
  ...
}:
{
  programs = {
    niri.enable = true;
    dconf.enable = true;
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time";
        user = "greeter";
      };
    };
  };

  xdg.portal = {
    extraPortals = [
      pkgs.xdg-desktop-portal-gnome
      pkgs.xdg-desktop-portal-gtk
    ];

    config =
      let
        portalConf = {
          default = [
            "gnome"
            "gtk"
          ];
        };
      in
      {
        common = portalConf;
        niri = portalConf;
      };
  };

  environment.sessionVariables = {
    DISPLAY = ":0";
  };

  home-manager.sharedModules = [
    flake.homeModules.xwayland-satellite
  ];
}
