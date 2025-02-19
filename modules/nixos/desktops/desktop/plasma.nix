{
  lib,
  pkgs,
  config,
  namespace,
  ...
}: let
  cfg = config.${namespace}.desktops.plasma;
in {
  options.${namespace} = {
    desktops.plasma = {
      enable = lib.mkEnableOption "KDE Plasma";
    };
  };

  config = lib.mkIf cfg.enable {
    services.desktopManager.plasma6 = {
      enable = true;
    };

    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };

    environment.plasma6.excludePackages = with pkgs; [
      kdePackages.konsole
    ];

    services.power-profiles-daemon.enable = lib.mkForce false;
  };
}
