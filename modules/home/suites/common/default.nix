{
  lib,
  config,
  namespace,
  ...
}:
lib.${namespace}.mkModule ./. config {
  enable = lib.mkEnableOption "the common home suite";
} {
  anima = {
    apps = {
      vesktop.enable = true;
      firefox.enable = true;

      vscode.enable = true;
      helix.enable = true;
      wezterm.enable = true;

      xsane.enable = true;
    };

    misc = {
      fonts.enable = true;
    };
  };
}
