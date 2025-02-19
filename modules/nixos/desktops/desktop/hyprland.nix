{
  lib,
  pkgs,
  config,
  namespace,
  ...
}: let
  cfg = config.${namespace}.desktops.hyprland;
in {
  options.${namespace} = {
    desktops.hyprland = {
      enable = lib.mkEnableOption "Hyprland";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
    };

    security.polkit.enable = true;
    security.soteria.enable = true;

    environment.systemPackages = [
      pkgs.wl-clipboard
    ];
  };
}
