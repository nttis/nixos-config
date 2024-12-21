{
  lib,
  config,
  namespace,
  ...
}:
lib.${namespace}.mkModule ./. config {
  enable = lib.mkEnableOption "i3 window manager";
} {
  services.xserver.windowManager.i3 = {
    enable = true;
  };
}
