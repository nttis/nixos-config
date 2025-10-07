{ ... }:
{
  flake.modules.homeManager."gpg@delta" =
    { pkgs, ... }:
    {
      programs.gpg = {
        enable = true;
        mutableKeys = false;
        mutableTrust = false;
      };

      services.gpg-agent = {
        enable = true;
        enableExtraSocket = true;
        enableFishIntegration = true;
        enableSshSupport = true;

        sshKeys = [
          "CEF7502F9CDBFE9F2620C211A3F86533DED615D0"
        ];

        pinentry = {
          package = pkgs.pinentry-all;
          program = "pinentry-gnome3";
        };
      };
    };
}
