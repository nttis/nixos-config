{
  pkgs,
  lib,
  config,
  ...
}:
let
  serviceConf = {
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
      {
        factory = "adapter";
        args = {
          "node.name" = "Virtual-Sink";
          "node.description" = "Virtual Sink";

          "factory.name" = "support.null-audio-sink";

          "media.class" = "Audio/Sink";
          "audio.position" = "MONO";
        };
      }
    ];
  };
in
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
        "10-wtf" = serviceConf;
      };
    };

    systemd.user.services.pipewire-link = {
      enable = true;

      wantedBy = [ "default.target" ];
      requires = [
        "wireplumber.service"
      ];
      after = [
        "wireplumber.service"
      ];

      script = ''
        sleep 5 # I am so desperate

        ${pkgs.pipewire}/bin/pw-link "Virtual-Sink:monitor_MONO" "Virtual-Mic:input_MONO"
        ${pkgs.pipewire}/bin/pw-link "Virtual-Mic:capture_MONO" "alsa_output.pci-0000_00_1f.3.analog-stereo:playback_FL"
        ${pkgs.pipewire}/bin/pw-link "Virtual-Mic:capture_MONO" "alsa_output.pci-0000_00_1f.3.analog-stereo:playback_FR"
      '';
    };
  };
}
