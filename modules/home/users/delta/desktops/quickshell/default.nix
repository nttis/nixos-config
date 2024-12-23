{
  inputs,
  lib,
  config,
  namespace,
  system,
  ...
}:
lib.${namespace}.mkModule ./. config {
  enable = lib.mkEnableOption "Quickshell configuration";
} {
  home.packages = with inputs; [
    quickshell.packages.${system}.default
  ];
}
