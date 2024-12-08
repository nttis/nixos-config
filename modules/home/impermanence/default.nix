{
  lib,
  config,
  namespace,
  ...
}:
lib.${namespace}.mkModule ./. config {
  enable = lib.mkEnableOption "Impermanence";
} {
  home.persistence."/persist/${config.snowfallorg.user.name}" = {
    directories = [
      "Downloads"

      ".ssh"

      ".local/share/keyrings"
      ".local/share/direnv"

      ".var"
    ];
    allowOther = true;
  };
}
