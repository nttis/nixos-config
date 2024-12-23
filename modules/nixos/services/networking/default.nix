{
  lib,
  config,
  namespace,
  ...
}:
lib.${namespace}.mkModule ./. config {
  enable = lib.mkEnableOption "networking";
} {
  networking.networkmanager = {
    enable = true;
    wifi.backend = "iwd";
  };

  networking.wireless.iwd = {
    enable = true;
  };

  programs.nm-applet.enable = true;
}
