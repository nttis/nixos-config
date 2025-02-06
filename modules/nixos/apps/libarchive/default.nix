{
  lib,
  pkgs,
  config,
  namespace,
  ...
}:
lib.${namespace}.mkModule ./. config {
  enable = lib.mkEnableOption "libarchive, including its CLI utilities";
} {
  environment.systemPackages = [
    pkgs.libarchive
  ];
}
