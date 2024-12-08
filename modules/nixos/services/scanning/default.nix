{
  lib,
  config,
  namespace,
  ...
}: {
  options.${namespace}.services.scanning = {
    enable = lib.mkEnableOption "scanning";
  };

  config = lib.mkIf config.${namespace}.services.scanning.enable {
    hardware.sane.enable = true;
  };
}
