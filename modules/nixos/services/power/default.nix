{
  lib,
  namespace,
  config,
  ...
}:
lib.${namespace}.mkModule ./. config {
  enable = lib.mkEnableOption "powersaving options";
} {
  services.thermald = {
    enable = true;
  };

  services.tlp = {
    enable = true;
    settings = {
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

      CPU_MAX_PERF_ON_BAT = 25;

      START_CHARGE_THRESH_BAT0 = 85;
      STOP_CHARGE_THRES_BAT0 = 90;
    };
  };
}
