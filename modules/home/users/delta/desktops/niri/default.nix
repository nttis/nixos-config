{
  inputs,
  lib,
  config,
  pkgs,
  system,
  namespace,
  ...
}:
lib.${namespace}.mkModule ./. config {
  enable = lib.mkEnableOption "user-specific Niri config";
} {
  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
      target = "graphical-session.target";
    };
  };

  xdg.configFile."niri/config.kdl" = {
    enable = true;
    source = ./config.kdl;
  };

  home.packages = with pkgs; [
    wireplumber
    brightnessctl
    rofi-wayland
  ];
}
