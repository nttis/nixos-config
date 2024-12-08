{
  lib,
  config,
  namespace,
  ...
}: {
  options.${namespace}.suites.common = {
    enable = lib.mkEnableOption "the common home suite";
  };

  config = lib.mkIf config.${namespace}.suites.common.enable {
    anima = {
      apps = {
        vesktop.enable = true;
        firefox.enable = true;

        vscode.enable = true;
        kitty.enable = true;
        kakoune.enable = true;
      };

      fonts.enable = true;
    };
  };
}
