{
  lib,
  namespace,
  config,
  ...
}:
lib.${namespace}.mkModule ./. config {
  enable = lib.mkEnableOption "gitui - terminal Git client";
} {
  programs.gitui = {
    enable = true;
  };
}
