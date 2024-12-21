{
  lib,
  config,
  namespace,
  ...
}:
lib.${namespace}.mkModule ./. config {
  enable = lib.mkEnableOption "user-specific i3 config";
} {
  xsession.windowManager.i3 = {
    enable = true;
    extraConfig = lib.readFile ./config;
  };
}
