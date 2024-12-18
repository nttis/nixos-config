{
  lib,
  config,
  namespace,
  ...
}:
lib.${namespace}.mkModule ./. config {
  enable = lib.mkEnableOption "user-specific git config";
} {
  anima = {
    apps = {
      git = {
        enable = true;
        userName = "nttis";
        userEmail = "42465069+nttis@users.noreply.github.com";
      };
    };
  };
}
