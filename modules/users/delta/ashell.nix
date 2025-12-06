{ ... }:
{
  flake.modules.homeManager."ashell@delta" = {
    programs.ashell = {
      enable = true;

      systemd = {
        enable = true;
        target = "wayland-barebones.target";
      };

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
