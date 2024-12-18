# Actually is nixcord
{
  lib,
  config,
  namespace,
  ...
}:
lib.${namespace}.mkModule ./. config {
  enable = lib.mkEnableOption "enables Vesktop";
} {
  # Persist data if Impermanence is enabled
  home = lib.mkIf config.${namespace}.impermanence.enable {
    persistence."/persist/${config.snowfallorg.user.name}" = {
      directories = [
        ".config/vesktop"
      ];
    };
  };

  programs.nixcord = {
    enable = true;

    # Use Vesktop
    discord.enable = false;
    vesktop.enable = true;
  };
}
