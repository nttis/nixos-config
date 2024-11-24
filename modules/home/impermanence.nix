{ lib, config, ... }:
{
  options = {
    impermanence.enable = lib.mkEnableOption "enables Impermanence";
  };

  config = lib.mkIf config.impermanence.enable {
    home.persistence."/persist/delta" = {
      directories = [
        ".ssh"

        ".local/share/keyrings"
        ".local/share/direnv"

        ".local/share/flatpak"
        ".var"

        ".local/share/Mindustry"
        ".config/vesktop"

        ".mozilla"
      ];
      allowOther = true;
    };
  };
}
