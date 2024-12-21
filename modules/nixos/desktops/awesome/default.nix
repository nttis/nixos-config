{
  lib,
  config,
  pkgs,
  namespace,
  ...
}:
lib.${namespace}.mkModule ./. config {
  enable = lib.mkEnableOption "awesome window manager";
} {
  services.xserver.windowManager.awesome = {
    enable = true;
  };
}
