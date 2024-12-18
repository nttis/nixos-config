{
  lib,
  config,
  namespace,
  ...
}:
lib.${namespace}.mkModule ./. config {
  enable = lib.mkEnableOption "user-specific Helix config";
} {
  anima = {
    apps = {
      helix.enable = true;
    };
  };

  programs.helix = {
    settings = {
      editor.cursor-shape = {
        insert = "bar";
        normal = "bar";
        select = "underline";
      };
    };
  };
}
