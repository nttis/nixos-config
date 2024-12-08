{
  lib,
  config,
  namespace,
  ...
}:
lib.${namespace}.mkModule ./. config {
  enable = lib.mkEnableOption "font management";
} {
  fonts.fontconfig.enable = true;
}
