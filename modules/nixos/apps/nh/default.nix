{
  lib,
  config,
  namespace,
  ...
}:
lib.${namespace}.mkModule ./. config {
  enable = lib.mkEnableOption "the nh Nix utility";
} {
  programs.nh = {
    enable = true;
    flake = "/persist/nixos";
  };
}
