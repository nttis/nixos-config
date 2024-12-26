{
  lib,
  config,
  namespace,
  ...
}:
lib.${namespace}.mkModule ./. config {
  enable = lib.mkEnableOption "qutebrowser";
} {
  programs.qutebrowser = {
    enable = true;
  };
}
