{
  lib,
  config,
  namespace,
  ...
}:
lib.${namespace}.mkModule ./. config {
  enable = lib.mkEnableOption "sops-nix secrets management";
} {
  sops.defaultSopsFile = lib.snowfall.fs.get-snowfall-file "secrets/default.yaml";

  sops.age.keyFile =
    if config.${namespace}.impermanence.enable
    then "/persist/system/var/lib/sops-nix/keys.txt"
    else "/var/lib/sops-nix/keys.txt";
}
