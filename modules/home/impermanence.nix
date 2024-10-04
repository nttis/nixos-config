{ lib, config, ... }:
{
  options = {
    impermanence.enable = lib.mkEnableOption "enables Impermanence";
  };

  config = lib.mkIf config.impermanence.enable {
    home.persistence."/persist/delta" = {
      directories = [
        ".ssh"
        ".gnupg"

        ".local/share/keyrings"
        ".local/share/direnv"

        ".local/share/flatpak"
        ".var"

        ".config/vesktop"

        ".mozilla"
      ];
      allowOther = true;
    };
  };
}
