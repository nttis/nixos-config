{
  lib,
  config,
  namespace,
  pkgs,
  ...
}: {
  options.${namespace}.desktops.xfce = {
    enable = lib.mkEnableOption "xfce desktop environment";
  };

  config = lib.mkIf config.${namespace}.desktops.xfce.enable {
    services.xserver = {
      enable = true;
      excludePackages = [pkgs.xterm];

      desktopManager = {
        xterm.enable = false;
        xfce.enable = true;
      };
    };

    services.displayManager.defaultSession = "xfce";
    services.picom = {
      enable = true;
      fade = true;
      shadow = true;
      fadeDelta = 4;
    };
  };
}