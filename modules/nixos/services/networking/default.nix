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
  };

  programs.nm-applet.enable = true;
}
