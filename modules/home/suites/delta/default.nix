{
  lib,
  config,
  namespace,
  ...
}: {
  options.${namespace}.suites.delta = {
    enable = lib.mkEnableOption "delta's suite";
  };

  config = lib.mkIf config.${namespace}.suites.delta.enable {
    snowfallorg.user.name = "delta";

    anima = {
      suites = {
        common.enable = true;
      };

      apps = {
        git = {
          enable = true;

          userName = "N";
          userEmail = "42465069+ofcoursenopewastaken@users.noreply.github.com";

          signing = {
            enable = true;
          };
        };
      };

      impermanence.enable = true;
    };
  };
}
