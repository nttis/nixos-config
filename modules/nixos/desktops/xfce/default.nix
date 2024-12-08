{
  lib,
  config,
  pkgs,
  namespace,
  ...
}:
lib.${namespace}.mkModule ./. config {
  enable = lib.mkEnableOption "the xfce desktop environment";
} {
  services.xserver = {
    enable = true;
    excludePackages = [pkgs.xterm];

    desktopManager = {
      xterm.enable = false;
      xfce.enable = true;
    };
  };

  services.picom = {
    enable = true;
    fade = true;
    shadow = true;
    fadeDelta = 4;
  };
}
