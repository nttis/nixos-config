{
  lib,
  config,
  ...
}:
{
  options = {
    git.enable = lib.mkEnableOption "enables git";
  };

  config = lib.mkIf config.git.enable {
    programs.git = {
      enable = true;

      userName = "N";
      userEmail = "42465069+ofcoursenopewastaken@users.noreply.github.com";

      extraConfig = {
        user.signingkey = "~/.ssh/id_ed25519.pub";
        gpg.format = "ssh";
        commit.gpgsign = true;
      };
    };
  };
}
