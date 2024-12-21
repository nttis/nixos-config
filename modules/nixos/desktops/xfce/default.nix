{
  lib,
  config,
  namespace,
  ...
}:
lib.${namespace}.mkModule ./. config {
  enable = lib.mkEnableOption "the xfce desktop environment";
} {
  anima = {
    desktops = {
      xserver.enable = true;
    };
  };

  services.xserver = {
    desktopManager = {
      xfce.enable = true;
    };
  };
}
