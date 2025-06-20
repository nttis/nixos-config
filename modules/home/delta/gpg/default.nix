{pkgs, ...}: {
  programs.gpg = {
    enable = true;
    mutableKeys = false;
    mutableTrust = false;

    publicKeys = [
      {
        source = ./pubkeys/datto_0x72023C25_public.asc;
        trust = 5;
      }

      {
        source = ./pubkeys/0x44DB1FA6B33CEF5C_public.asc;
        trust = 5;
      }

      {
        source = ./pubkeys/0xB6A5EA06478F6A48_public.asc;
        trust = 5;
      }
    ];
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
      program = "pinentry";
    };
  };
}
