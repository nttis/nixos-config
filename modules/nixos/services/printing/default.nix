{
  lib,
  config,
  pkgs,
  namespace,
  ...
}: {
  options.${namespace}.services.printing = {
    enable = lib.mkEnableOption "printing";
  };

  config = lib.mkIf config.${namespace}.services.printing.enable {
    services.printing = {
      enable = true;
      drivers = with pkgs; [
        gutenprint
        gutenprintBin
        hplip
        brlaser
        brgenml1cupswrapper
        brgenml1lpr
      ];
    };
  };
}
