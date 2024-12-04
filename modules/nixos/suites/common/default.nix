{
  lib,
  config,
  pkgs,
  namespace,
  ...
}: {
  options.${namespace}.suites.common = {
    enable = lib.mkEnableOption "common configurations";
  };

  config = lib.mkIf config.${namespace}.suites.common.enable {
    anima = {
      boot.systemd.enable = true;
      filesystem.enable = true;

      apps = {
        nh.enable = true;
      };

      desktops.xfce.enable = true;
    };

    programs.fish.enable = true;

    users.mutableUsers = false;
    users.defaultUserShell = pkgs.fish;
  };
}
