{
  lib,
  namespace,
  config,
  pkgs,
  ...
}:
lib.${namespace}.mkModule ./. config {
  enable = lib.mkEnableOption "LibreOffice";
} {
  home.packages = with pkgs; [
    libreoffice
  ];
}
