{
  lib,
  config,
  namespace,
  ...
}:
lib.${namespace}.mkModule ./. config {
  enable = lib.mkEnableOption "common filesystem mounts";
} {
  fileSystems."/" = {
    device = "/dev/disk/by-label/nix";
    fsType = "btrfs";
    options = ["subvol=root"];
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-label/nix";
    fsType = "btrfs";
    options = [
      "subvol=nix"
      "noatime"
    ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/ESP";
    options = [
      "umask=0077"
      "defaults"
    ];
  };

  swapDevices = [
    {
      device = "/dev/disk/by-label/swap";
    }
  ];
}
