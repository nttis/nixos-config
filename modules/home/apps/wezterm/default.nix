{
  inputs,
  lib,
  config,
  system,
  namespace,
  ...
}:
lib.${namespace}.mkModule ./. config {
  enable = lib.mkEnableOption "wezterm terminal emulator";
} {
  programs.wezterm = {
    enable = true;
    package = inputs.wezterm.packages.${system}.default;
    extraConfig = lib.readFile ./config.lua;
  };
}
