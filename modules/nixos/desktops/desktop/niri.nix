{
  lib,
  config,
  namespace,
  ...
}: let
  cfg = config.${namespace}.desktops.niri;
in {
  options.${namespace} = {
    desktops.niri = {
      enable = lib.mkEnableOption "the Niri scrolling-tiling window manager";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.niri = {
      enable = true;
    };
  };
}
