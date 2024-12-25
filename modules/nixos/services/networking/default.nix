{
  lib,
  config,
  pkgs,
  namespace,
  ...
}:
lib.${namespace}.mkModule ./. config {
  enable = lib.mkEnableOption "networking";
} {
  services.connman = {
    enable = true;
    enableVPN = true;

    package = pkgs.connmanFull;

    wifi.backend = "iwd";
  };

  environment.persistence."/persist/system" = lib.mkIf config.${namespace}.impermanence.enable {
    directories = [
      "/var/lib/connman"
    ];
  };
}
