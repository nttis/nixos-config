{
  lib,
  config,
  pkgs,
  namespace,
  ...
}:
lib.${namespace}.mkModule ./. config {
  enable = lib.mkEnableOption "Chromium";
} {
  programs.chromium = {
    enable = true;
    package = pkgs.ungoogled-chromium;
  };
}
