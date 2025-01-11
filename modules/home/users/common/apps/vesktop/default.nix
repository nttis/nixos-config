# Actually is nixcord
{
  lib,
  config,
  pkgs,
  namespace,
  ...
}: let
  user = config.snowfallorg.user.name;

  equibop = pkgs.equibop.override {
    withSystemEquicord = false;
    equicord = pkgs.stdenv.mkDerivation {
      name = "stub";
      phases = [];
    };
  };
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
      discord = {
        enable = false;
        vencord = {
          enable = false;
          unstable = true; # To fix the fucking hash mismatch errors even though we don't even use vencord
        };
      };

      vesktop = {
        enable = true;
        package = pkgs.makeOverridable pkgs.stdenvNoCC.mkDerivation {
          name = "equibop-wrapper";
          phases = ["installPhase"];

          nativeBuildInputs = [
            pkgs.makeWrapper
          ];

          installPhase = ''
            mkdir -p $out
            cp -r ${equibop}/* $out

            chmod -R 755 $out

            wrapProgram $out/bin/equibop \
              --set EQUICORD_USER_DATA_DIR ${config.xdg.configHome + "/vesktop"}
          '';
        };
      };
    };
  }
