{
  lib,
  config,
  pkgs,
  namespace,
  ...
}:
lib.${namespace}.mkModule ./. config {
  enable = lib.mkEnableOption "user-specific nushell config";
} {
  programs.nushell = {
    enable = true;
    shellAliases = {
      tree = "${pkgs.eza}/bin/eza --tree";
      cat = "${pkgs.bat}/bin/bat";
    };
  };
}
