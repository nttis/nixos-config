{ ... }:
let
  images = [
    "png"
    "apng"
    "jpeg"
    "jxl"
    "svg"
    "svg+xml"
    "tiff"
    "gif"
    "webp"
    "avif"
    "heic"
    "heif"
  ];

  audio = [
    "flac"
    "aac"
    "matroska"
    "mpeg"
    "ogg"
    "opus"
    "vorbis"
  ];

  schemes = [
    "http"
    "https"
  ];

  mapAssocs =
    prefix: assocs: list:
    (builtins.map (x: {
      name = prefix + x;
      value = assocs;
    }) list);

  associations = builtins.listToAttrs (
    builtins.concatLists [
      (mapAssocs "audio/" [ "mpv.desktop" ] audio)
      (mapAssocs "image/" [ "feh.desktop" ] images)
      (mapAssocs "x-scheme-handler/" [ "org.qutebrowser.qutebrowser.desktop" "firefox.desktop" ] schemes)
    ]
  );
in
{
  imports = [
    ./feh.nix
    ./qutebrowser
  ];

  programs.mpv.enable = true;

  xdg.mime.enable = true;
  xdg.mimeApps = {
    enable = true;
    defaultApplications = associations;
    associations.added = associations;
  };
}
