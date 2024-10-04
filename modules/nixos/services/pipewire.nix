{ lib, config, ... }:
{
  options = {
    pipewire.enable = lib.mkEnableOption "enables Pipewire";
  };

  config = lib.mkIf config.pipewire.enable {
    services.pipewire = {
      enable = true;
      pulse.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      jack.enable = true;

      extraConfig.pipewire = {
        "10-wtf" = {
          "context.objects" = [
            {
              factory = "adapter";
              args = {
                "node.name" = "Virtual-Mic";
                "node.description" = "Virtual Microphone";

                "factory.name" = "support.null-audio-sink";

                "media.class" = "Audio/Source/Virtual";
                "audio.position" = "MONO";
              };
            }
          ];
        };
      };
    };
  };
}
