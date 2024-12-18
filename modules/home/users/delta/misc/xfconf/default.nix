{
  lib,
  config,
  namespace,
  ...
}:
lib.${namespace}.mkModule ./. config {
  enable = lib.mkEnableOption "user-specific xfconf config";
} {
  xfconf.settings = {
    "xfce4-terminal" = {
      "misc-cursor-blinks" = true;
      "misc-cursor-shape" = "TERMINAL_CURSOR_SHAPE_IBEAM";
      "scrolling-unlimited" = true;
      "title-mode" = "TERMINAL_TITLE_REPLACE";
    };

    "thunar" = {
      "last-show-hidden" = true;
    };
  };
}
