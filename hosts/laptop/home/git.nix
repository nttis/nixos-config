{ ... }:
{
  programs.git = {
    enable = true;

    userName = "N";
    userEmail = "42465069+ofcoursenopewastaken@users.noreply.github.com";

    extraConfig = {
      user.signingkey = "~/.ssh/id_ed25519.pub";
      gpg.format = "ssh";
    };
  };
}
