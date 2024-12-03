{
  lib,
  config,
  namespace,
  ...
}: {
  options.${namespace}.impermanence = {
    enable = lib.mkEnableOption "Impermanence";
  };

  config = lib.mkIf config.${namespace}.impermanence.enable {
    home.persistence."/persist/${config.snowfallorg.user.name}" = {
      directories = [
        "Downloads"

        ".ssh"

        ".local/share/keyrings"
        ".local/share/direnv"

        ".var"

        ".mozilla"
      ];
      allowOther = true;
    };
  };
}
