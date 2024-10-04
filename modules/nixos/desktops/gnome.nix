{ lib, config, ... }:
{
  options = {
    gnome.enable = lib.mkEnableOption "enables GNOME";
  };

  config = lib.mkIf config.gnome.enable {
    services.xserver.enable = true;
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;
  };
}
