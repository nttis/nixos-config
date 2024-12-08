{
  lib,
  config,
  namespace,
  ...
}: {
  options.${namespace}.apps.kakoune = {
    enable = lib.mkEnableOption "kakoune text editor";
  };

  config = lib.mkIf config.${namespace}.apps.kakoune.enable {
    programs.kakoune = {
      enable = true;
    };
  };
}
