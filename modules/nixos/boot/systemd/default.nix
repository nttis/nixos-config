{
  lib,
  config,
  namespace,
  ...
}: {
  options.${namespace}.boot.systemd = {
    enable = lib.mkEnableOption "systemd boot";
  };

  config = lib.mkIf config.${namespace}.boot.systemd.enable {
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
  };
}
