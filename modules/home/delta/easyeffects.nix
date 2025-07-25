{pkgs, ...}: {
  systemd.user.services.mic-volume = {
    Unit = {
      Description = "Lower microphone volume";
      After = ["graphical-session.target" "wireplumber.target"];
    };

    Service = {
      Type = "exec";
      ExecStart = "${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 30%";
      Restart = "on-failure";
    };

    Install = {
      WantedBy = ["graphical-session.target" "wireplumber.target"];
    };
  };
}
