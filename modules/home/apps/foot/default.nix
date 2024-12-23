{
  lib,
  config,
  namespace,
  ...
}:
lib.${namespace}.mkModule ./. config {
  enable = lib.mkEnableOption "foot terminal emulator";
} {
  programs.foot = {
    enable = true;
  };
}
