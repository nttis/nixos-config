{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
lib.${namespace}.mkModule ./. config {
  enable = lib.mkEnableOption "xsane";
} {
  home.packages = [
    pkgs.xsane
  ];
}
