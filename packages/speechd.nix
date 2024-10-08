{
  writeText,
  fetchurl,

  speechd,
  mpv,
  ffmpeg,
  piper-tts,
}:
let
  speechdConfig = writeText "speechd.conf" ''
    LogDir "default"

    SymbolsPreproc "char"
    SymbolsPreprocFile "gender-neutral.dic"
    SymbolsPreprocFile "font-variants.dic"
    SymbolsPreprocFile "symbols.dic"
    SymbolsPreprocFile "emojis.dic"
    SymbolsPreprocFile "orca.dic"
    SymbolsPreprocFile "orca-chars.dic"

    AddModule "piper" "sd_generic" "piper.conf"
    AddModule "flite" "sd_flite" "flite.conf"
    AddModule "pico" "sd_pico" "pico.conf"

    DefaultVoiceType "male1"
    DefaultLanguage en-GB
    DefaultModule piper

    Include "clients/*.conf"
  '';

  piperConfig = writeText "piper.conf" ''
    GenericExecuteSynth "export XDATA=\'$DATA\'; echo \"$XDATA\" | sed -z 's/\\n/ /g' | ${piper-tts}/bin/piper -q -m __OUTPATH__/models/alan.onnx --output-raw | ${ffmpeg}/bin/ffmpeg -f s16le -ac 1 -ar 22050 -i pipe:0 -f wav pipe:1 | ${mpv}/bin/mpv --audio-device=pipewire/Virtual-Sink --no-terminal --keep-open=no -"

    AddVoice "en-GB" "male1" "alan"
  '';
in
speechd.overrideAttrs (oldAttrs: rec {
  models = [
    (fetchurl {
      url = "https://huggingface.co/rhasspy/piper-voices/resolve/2083514c726ed4e54d15dbf8d86285d6059642f0/en/en_GB/alan/medium/en_GB-alan-medium.onnx";
      hash = "sha256-CjCWaJMiBedigB8e/Cc2zUsBIDKWIq32K+CeVjOdMzA=";
      name = "alan.onnx";
    })
    (fetchurl {
      url = "https://huggingface.co/rhasspy/piper-voices/resolve/2083514c726ed4e54d15dbf8d86285d6059642f0/en/en_GB/alan/medium/en_GB-alan-medium.onnx.json";
      hash = "sha256-wPDRJOWJXADnwDs13MgofzGaaZijZbGC3rXI51LujB4=";
      name = "alan.onnx.json";
    })
  ];

  postInstall = ''
    mkdir $out/models

    cp ${builtins.elemAt models 0} $out/models/alan.onnx
    cp ${builtins.elemAt models 1} $out/models/alan.onnx.json

    cp ${speechdConfig} $out/etc/speech-dispatcher/speechd.conf
    cp ${piperConfig} $out/etc/speech-dispatcher/modules/piper.conf

    sed -i "s|__OUTPATH__|$out|g" $out/etc/speech-dispatcher/modules/piper.conf
  '';
})
