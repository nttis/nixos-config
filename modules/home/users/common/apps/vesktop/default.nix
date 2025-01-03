# Actually is nixcord
{
  lib,
  config,
  pkgs,
  namespace,
  ...
}: let
  user = config.snowfallorg.user.name;
in
  lib.${namespace}.mkModule ./. config {
    enable = lib.mkEnableOption "enables Equibop";
  } {
    # Persist data if Impermanence is enabled
    home = lib.mkIf config.${namespace}.users.${user}.impermanence.enable {
      persistence."/persist/${user}" = {
        directories = [
          ".config/vesktop"
        ];
      };
    };

    programs.nixcord = {
      enable = true;

      # Use Equibop
      discord.enable = false;

      vesktop = {
        enable = true;
        package = pkgs.makeOverridable pkgs.stdenvNoCC.mkDerivation {
          name = "stub";
          phases = ["installPhase"];

          nativeBuildInputs = [
            pkgs.makeWrapper
          ];

          installPhase = ''
            mkdir -p $out
            cp -r ${pkgs.equibop}/* $out

            chmod -R 755 $out

            wrapProgram $out/bin/equibop \
              --set EQUICORD_USER_DATA_DIR ${config.xdg.configHome + "/vesktop"}
          '';
        };
      };
    };
  }
