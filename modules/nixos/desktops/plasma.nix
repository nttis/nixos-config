{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    plasma.enable = lib.mkEnableOption "enables KDE Plasma 6";
  };

  config = lib.mkIf config.plasma.enable {
    services.xserver.enable = true;
    services.displayManager.sddm.enable = true;
    services.displayManager.sddm.wayland.enable = true;
    services.desktopManager.plasma6.enable = true;

    # Remove KDE bloat
    environment.plasma6.excludePackages = with pkgs.kdePackages; [
      discover
      elisa
      konsole
      plasma-browser-integration
      ark
      krdp
      kwalletmanager
      kwallet-pam
      kwallet
      okular
      kate
      kwrited
      accessibility-inspector
    ];
  };
}
