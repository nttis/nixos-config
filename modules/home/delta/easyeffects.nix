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

  services.easyeffects = {
    enable = true;
    preset = "fuck";

    extraPresets.fuck = {
      input = {
        blocklist = [];

        plugins_order = [
          "echo_canceller#0"
          "rnnoise#0"
          "gate#0"
          "speex#0"
        ];

        "echo_canceller#0" = {
          bypass = false;
          filter-length = 100;
          input-gain = 0;
          output-gain = 10;
          residual-echo-suppression = -70;
          near-end-suppression = -70;
        };

        "gate#0" = {
          bypass = false;
          attack = 1;
          curve-threshold = -50;
          curve-zone = -2;
          dry = -100;
          hpf-frequency = 10;
          hpf-mode = "off";
          hysteresis = true;
          hysteresis-threshold = -3;
          hysteresis-zone = -1;
          input-gain = 0;
          output-gain = 0;
          lpf-frequency = 20000;
          lpf-mode = "off";
          makeup = 1;
          reduction = -15;
          release = 200;
          sidechain = {
            input = "Internal";
            lookahead = 0;
            mode = "RMS";
            preamp = 0;
            reactivity = 10;
            source = "Middle";
            stereo-split-source = "Left/Right";
          };
          stereo-split = false;
          wet = -1;
        };

        "rnnoise#0" = {
          bypass = false;
          enable-vad = false;
          input-gain = 0;
          model-path = "";
          output-gain = 0;
          release = 20;
          vad-thres = 50;
          wet = 0;
        };

        "speex#0" = {
          bypass = false;
          enable-agc = true;
          enable-denoise = true;
          enable-dereverb = true;
          noise-suppression = -70;
          input-gain = 0;
          output-gain = 0;
          vad = {
            enable = true;
            probability-continue = 90;
            probability-start = 95;
          };
        };
      };
    };
  };
}
