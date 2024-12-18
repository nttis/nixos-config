{
  lib,
  config,
  namespace,
  ...
}:
lib.${namespace}.mkModule ./. config {
  enable = lib.mkEnableOption "Firefox";
} {
  programs.firefox = {
    enable = true;
  };

  # Persist data if Impermanence is enabled
  home = lib.mkIf config.${namespace}.impermanence.enable {
    persistence."/persist/${config.snowfallorg.user.name}" = {
      directories = [
        ".mozilla"
      ];
    };
  };
}
