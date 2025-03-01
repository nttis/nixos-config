{
  inputs,
  lib,
  pkgs,
  config,
  namespace,
  ...
}: let
  username = config.snowfallorg.user.name;
in
  lib.${namespace}.mkModule ./. config {
    enable = lib.mkEnableOption "the AJATT apps";
  } {
    home.packages = with pkgs; [
      anki
      ffmpeg
      yt-dlp
      # goldendict-ng
    ];

    programs.mpv = {
      enable = true;
      scripts = with pkgs; [
        mpvScripts.mpvacious
        mpvScripts.mpris
      ];

      config = {
        volume-max = 200;
        subs-fallback = "yes";
      };

      scriptOpts = {
        subs2srs = {
          deck_name = "mpvacious";
          model_name = "Japanese sentences"; # Note type

          use_ffmpeg = "yes";
          audio_format = "opus";
          snapshot_format = "webp";

          autoclip_method = "goldendict";
          nuke_spaces = "yes";
          loudnorm = "yes";
        };
      };
    };

    xdg.configFile."goldendict/config" = {
      enable = true;
      force = true;
      text =
        /*
        xml
        */
        ''
          <config>
            <paths>
              <path recursive="1">${inputs.jitendex}</path>
            </paths>
            <preferences>
              <ankiConnectServer enabled="1">
                <host>127.0.0.1</host>
                <port>8765</port>
                <deck>mpvacious</deck>
                <model>Japanese sentences</model>
                <text>VocabDef</text>
                <word>VocabKanji</word>
                <sentence>SentKanji</sentence>
              </ankiConnectServer>

              <fullTextSearch>
                <enabled>0</enabled>
              </fullTextSearch>

              <checkForNewReleases>0</checkForNewReleases>
            </preferences>
          </config>
        '';
    };

    home.persistence."/persist/${username}" = lib.mkIf config.${namespace}.users.${username}.impermanence.enable {
      directories = [
        ".local/share/Anki2"
      ];
    };
  }
