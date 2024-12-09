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
      ".var"

      ".local/share/direnv"
    ];
    allowOther = true;
  };
}
