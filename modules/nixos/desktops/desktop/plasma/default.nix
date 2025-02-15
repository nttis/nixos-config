{
  lib,
  pkgs,
  config,
  namespace,
  ...
}:
lib.${namespace}.mkModule ./. config {
  enable = lib.mkEnableOption "KDE Plasma";
} {
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
}
