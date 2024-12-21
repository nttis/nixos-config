{
  lib,
  config,
  pkgs,
  namespace,
  ...
}:
lib.${namespace}.mkModule ./. config {
  enable = lib.mkEnableOption "Xorg server";
} {
  services.xserver = {
    enable = true;
    autorun = true;

    excludePackages = [pkgs.xterm];

    desktopManager = {
      # TIL xterm is also a desktop manager...
      xterm.enable = false;
    };
  };

  services.picom = {
    enable = true;
    fade = true;
    shadow = false;
    fadeDelta = 4;
  };
}
