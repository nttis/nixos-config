{
  lib,
  config,
  pkgs,
  namespace,
  ...
}:
lib.${namespace}.mkModule ./. config {
  enable = lib.mkEnableOption "scanning";
} {
  hardware.sane.enable = true;

  environment.systemPackages = with pkgs; [
    simple-scan
  ];
}
