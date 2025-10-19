{ ... }:
{
  flake.modules.nixos.gnome =
    { lib, ... }:
    {
      services.xserver.enable = lib.mkForce true;

      services.displayManager = {
        gdm = {
          enable = true;
          wayland = true;
        };

        defaultSession = "gnome";
      };

      services.desktopManager.gnome = {
        enable = true;
      };

      services.gnome = {
        core-os-services.enable = true;
        core-shell.enable = true;
      };
    };
}
