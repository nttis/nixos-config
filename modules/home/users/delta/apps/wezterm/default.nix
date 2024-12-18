{
  lib,
  config,
  namespace,
  ...
}:
lib.${namespace}.mkModule ./. config {
  enable = lib.mkEnableOption "user-specific wezterm terminal emulator config";
} {
  anima = {
    apps = {
      wezterm.enable = true;
    };
  };

  programs.wezterm = {
    extraConfig = lib.readFile ./config.lua;
  };
}
