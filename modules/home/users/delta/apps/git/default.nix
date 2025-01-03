{
  lib,
  config,
  namespace,
  ...
}:
lib.${namespace}.mkModule ./. config {
  enable = lib.mkEnableOption "user-specific git config";
} {
  programs.git = {
    enable = true;
    extraConfig = {
      user = {
        name = "nttis";
        email = "42465069+nttis@users.noreply.github.com";
      };
    };
  };
}
