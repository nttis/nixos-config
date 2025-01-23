{
  lib,
  config,
  namespace,
  ...
}:
lib.${namespace}.mkModule ./. config {
  enable = lib.mkEnableOption "theming and aesthetics-related configurations";
} {
  anima = {
    misc = {
      fonts.enable = true;
    };
  };
}
