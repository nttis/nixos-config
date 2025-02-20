{
  lib,
  config,
  namespace,
  ...
}: let
  cfg = config.${namespace}.services.upower;
in {
  options.${namespace} = {
    services.upower = {
      enable = lib.mkEnableOption "UPower";
    };
  };

  config = lib.mkIf cfg.enable {
    services.upower = {
      enable = true;
      criticalPowerAction = "Ignore";
      allowRiskyCriticalPowerAction = true;
    };
  };
}
