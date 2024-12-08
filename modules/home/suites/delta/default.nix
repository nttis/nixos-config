{
  lib,
  config,
  namespace,
  ...
}:
lib.${namespace}.mkModule ./. config {
  enable = lib.mkEnableOption "delta's suite";
} {
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
}
