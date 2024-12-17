{
  lib,
  config,
  namespace,
  ...
}:
lib.${namespace}.mkModule ./. config {
  enable = lib.mkEnableOption "Helix editor";
} {
  programs.helix = {
    enable = true;
  };
}
