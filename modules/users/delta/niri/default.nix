{ ... }:
{
  flake.modules.homeManager."niri@delta" = {
    xdg.configFile."niri/config.kdl" = {
      enable = true;
      force = true;
      source = ./config.kdl;
    };

    programs.ashell = {
      enable = true;
      systemd.enable = true;
      settings = {
        modules = {
          right = [
            [ "Tray" ]
            [ "Privacy" ]
            [ "Settings" ]
          ];

          center = [ "Clock" ];
        };
      };
    };
  };
}
