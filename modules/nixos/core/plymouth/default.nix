{
  lib,
  pkgs,
  config,
  namespace,
  ...
}:
lib.${namespace}.mkModule ./. config {
  enable = lib.mkEnableOption "Plymouth";
} {
  boot.plymouth = {
    enable = true;
    themePackages = [pkgs.nixos-bgrt-plymouth pkgs.plymouth-blahaj-theme];
    theme = "blahaj";
  };

  boot.initrd = {
    verbose = false;
  };

  boot = {
    consoleLogLevel = 0;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];
  };
}
