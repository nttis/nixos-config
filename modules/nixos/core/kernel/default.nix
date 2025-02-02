{
  lib,
  config,
  pkgs,
  namespace,
  ...
}:
lib.${namespace}.mkModule ./. config {
  enable = lib.mkEnableOption "the Linux kernel";

  distribution = lib.mkOption {
    description = "The kernel distribution to use";
    default = "latest";
    example = "zen";
    type = lib.types.enum ["zen" "latest"];
  };
} {
  boot.kernelPackages =
    if (config.${namespace}.core.kernel.distribution == "latest")
    then pkgs.linuxPackages_latest
    else pkgs.linuxPackages_zen;
}
