{
  lib,
  config,
  pkgs,
  namespace,
  ...
}:
lib.${namespace}.mkModule ./. config {
  enable = lib.mkEnableOption "latest Linux kernel";
} {
  boot.kernelPackages = pkgs.linuxPackages_latest;
}
