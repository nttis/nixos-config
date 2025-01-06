{
  lib,
  config,
  pkgs,
  namespace,
  ...
}: let
  username = config.snowfallorg.user.name;
in
  lib.${namespace}.mkModule ./. config {
    enable = lib.mkEnableOption "Anki";
  } {
    home.packages = [
      pkgs.anki-bin
    ];

    home.persistence."/persist/${username}" = lib.mkIf config.${namespace}.users.${username}.impermanence.enable {
      directories = [
        ".local/share/Anki2"
      ];
    };
  }
