{
  lib,
  config,
  namespace,
  ...
}:
lib.${namespace}.mkModule ./. config {
  enable = lib.mkEnableOption "librewolf";
} {
  programs.librewolf = {
    enable = true;
  };
}
