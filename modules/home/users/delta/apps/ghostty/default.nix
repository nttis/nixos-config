{
  lib,
  config,
  pkgs,
  namespace,
  ...
}:
lib.${namespace}.mkModule ./. config {
  enable = lib.mkEnableOption "ghostty terminal emulator";
} {
  home.packages = [
    pkgs.ghostty
  ];
}
