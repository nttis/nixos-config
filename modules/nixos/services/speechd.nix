{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    speechd.enable = lib.mkEnableOption "enables speechd + piper-tts TTS system";
  };

  config = lib.mkIf config.speechd.enable {
    services.speechd = {
      enable = true;
      package = pkgs.callPackage ../../../packages/speechd.nix { };
    };
  };
}
