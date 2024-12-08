{
  lib,
  config,
  namespace,
  ...
}: let
  cfg = config.${namespace}.apps.git;
in {
  options.${namespace}.apps.git = {
    enable = lib.mkEnableOption "git";

    userName = lib.mkOption {
      type = lib.types.str;
      description = "The username to pass to git";
    };

    userEmail = lib.mkOption {
      type = lib.types.str;
      description = "The email to pass to git";
    };

    signing = {
      enable = lib.mkEnableOption "signing commits";
      signingKey = lib.mkOption {
        type = lib.types.str;
        description = "Path to the SSH key to sign commits with";
        default = "~/.ssh/id_ed25519.pub";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    assertions = [
      {
        assertion = cfg.userName != null;
        message = "userName is required";
      }
      {
        assertion = cfg.userEmail != null;
        message = "userEmail is required";
      }

      (lib.mkIf cfg.signing.enable {
        assertion = cfg.signing.signingKey != null;
        message = "signingKey is required when signing is enabled";
      })
    ];

    programs.git = {
      enable = true;

      userName = cfg.userName;
      userEmail = cfg.userEmail;

      extraConfig = lib.mkIf cfg.signing.enable {
        user.signingkey = cfg.signing.signingKey;
        gpg.format = "ssh";
        commit.gpgsign = true;
      };
    };
  };
}
