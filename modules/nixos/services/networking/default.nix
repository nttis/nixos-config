{
  lib,
  config,
  namespace,
  ...
}: {
  options.${namespace}.services.networking = {
    enable = lib.mkEnableOption "networking";
  };

  config = lib.mkIf config.${namespace}.services.networking.enable {
    networking.networkmanager = {
      enable = true;
    };

    programs.nm-applet.enable = true;
  };
}
