{ ... }:
{
  flake.modules.nixos.virtual-mic =
    { pkgs, lib, ... }:
    {
      services.pipewire.extraConfig.pipewire = {
        "10-virtual-mic" = {
          "context.objects" = [
            {
              factory = "adapter";
              args = {
                "factory.name" = "support.null-audio-sink";
                "node.name" = "Virtual Source";
                "media.class" = "Audio/Source/Virtual";
                "audio.position" = [
                  "FL"
                  "FR"
                ];
                "monitor.channel-volumes" = true;
                "monitor.passthrough" = true;
                "adapter.auto-port-config" = {
                  "mode" = "dsp";
                  "monitor" = true;
                  "position" = "preserve";
                };
              };
            }
            {
              factory = "adapter";
              args = {
                "factory.name" = "support.null-audio-sink";
                "node.name" = "Virtual Sink";
                "media.class" = "Audio/Sink";
                "audio.position" = [
                  "FL"
                  "FR"
                ];
                "monitor.channel-volumes" = true;
                "monitor.passthrough" = true;
                "adapter.auto-port-config" = {
                  "mode" = "dsp";
                  "monitor" = true;
                  "position" = "preserve";
                };
              };
            }
          ];
        };
      };

      systemd.user.services.link-virtual-streams = {
        unitConfig = {
          Description = "Link virtual sink and source";
          After = [ "pipewire.service" ];
        };

        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;
        };

        script = lib.getExe (
          pkgs.writeShellApplication {
            name = "virtual-streams-link-script";

            runtimeInputs = with pkgs; [
              pipewire
              jq
            ];

            text = ''
              # mfw rigorous ordering by systemd and you still need a `sleep` call anyway
              sleep 1
              pw-link "Virtual Sink" "Virtual Source"

              default_sink="$(pw-dump | jq --raw-output '.[].metadata[]? | select(.key == "default.audio.sink") | .value.name')"
              pw-link "Virtual Source" "$default_sink"
            '';
          }
        );

        upheldBy = [ "pipewire.service" ];
        bindsTo = [ "pipewire.service" ];
      };
    };
}
