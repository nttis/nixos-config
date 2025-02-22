{
  lib,
  config,
  pkgs,
  namespace,
  ...
}:
lib.${namespace}.mkModule ./. config {
  enable = lib.mkEnableOption "greetd";
} {
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time";
        user = "greeter";
      };
    };
  };

  services.xserver.displayManager.startx.enable = true;
}
