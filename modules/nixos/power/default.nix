# Powersaving options
{ ... }:
{
  imports = [ ];

  services.thermald = {
    enable = true;
  };

  services.tlp = {
    enable = true;
    settings = {
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_SCALING_GOVERNER_ON_AC = "performance";
    };
  };
}
