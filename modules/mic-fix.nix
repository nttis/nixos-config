{ ... }:
{
  # Fix stupidly loud microphone input volume
  flake.modules.nixos.mic-fix =
    { pkgs, ... }:
    {
      systemd.services.mic-fix = {
        unitConfig = {
          Description = "Lower microphone volume";
          After = [
            "default.target"
            "wireplumber.target"
          ];
        };

        serviceConfig = {
          Type = "exec";
          ExecStart = "${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 30%";
          Restart = "on-failure";
        };

        wantedBy = [
          "wireplumber.target"
        ];
      };
    };
}
