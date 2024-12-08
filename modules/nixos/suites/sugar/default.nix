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
    apps = {
      stylix.enable = true;
    };

    misc = {
      fonts.enable = true;
    };
  };
}
