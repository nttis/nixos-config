{...}: {
  imports = [
    ./feh.nix
  ];

  programs.mpv.enable = true;

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "image/*" = ["feh.desktop"];
      "audio/*" = ["mpv.desktop"];
    };
  };
}
