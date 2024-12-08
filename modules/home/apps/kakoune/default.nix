{
  lib,
  config,
  namespace,
  ...
}:
lib.${namespace}.mkModule ./. config {
  enable = lib.mkEnableOption "kakoune text editor";
} {
  programs.kakoune = {
    enable = true;
  };
}
